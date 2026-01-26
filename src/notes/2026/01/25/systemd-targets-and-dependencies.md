---
title: Systemd Targets and Dependencies
date: 2026-01-25T14:46:44+00:00
---

---

**tl;dr:** If you know the background details and just need some quick syntax reminders,
checkout the [summary at the bottom](#summary).

---

I modify systemd unit files maybe a couple of times per year. That’s often enough that
it’s useful for me to understand them well, but not often enough for those details to
stick in my brain.

So I wrote this for myself or for anyone else who might be in a similar situation.
It’s for anyone who needs a quick refresher on systemd targets, `Wants=`, `Requires=`,
`WantedBy=`, `RequiredBy=`, `Before=`, and `After=`.

Before I get into the real content, it's useful to have an example systemd unit file
in your head for context. I chose Tailscale (copy / pasted from my laptop running
Archlinux):

```ini
# /usr/lib/systemd/system/tailscaled.service
[Unit]
# Details omitted for brevity
Wants=network-pre.target
After=network-pre.target NetworkManager.service systemd-resolved.service

[Service]
# Details omitted for brevity

[Install]
WantedBy=multi-user.target
```

## The Dependency Graph

Systemd maintains a dependency graph of units.[^1] These units can include,
for example, generic "targets" (which describe overall system states) such as
`network-online.target`, or specific background services like `tailscaled.service`.
There are other kinds of systemd units, but these are the most common types we interact
with.

[^1]: Tools like `systemd-analyze` and `systemctl list-dependencies` let you inspect
    various parts of the dependency graph. On a typical desktop Linux system, the full
    dependency graph is _huge_.

This dependency graph is important because as your system changes state (online vs.
offline, starting up vs. shutting down, etc.), certain things must happen in a specific
order. For instance, it doesn’t make sense to start the Tailscale service before your
DNS resolver is ready.

A key strength of systemd’s design is that you can precisely add entries to this graph
without performing invasive surgery on your operating system.

Most of what follows applies regardless of whether you're working with targets,
services, or other types of systemd **units** — the concepts are largely consistent
across unit types.

## Activation States

When a unit is activated, it eventually reaches a final activation state: either
"active" or "failed." If a unit was never intended to be activated, it remains
"inactive."

Understanding these states is important for understanding the difference between
"wanting" and "requiring" another unit.

## Establishing a Basic Dependency Relationship

When writing a unit file, the most basic way to establish a dependency on another unit
is using `Wants=` and `Requires=`.

* `Wants=` creates a soft dependency. If your unit includes `Wants=`, systemd will
  attempt to start the specified unit alongside yours. If that unit fails to activate,
  it doesn’t matter — your unit will still start.
* `Requires=` creates a hard dependency. It behaves similarly to `Wants=`, but if the
  target unit ends up in a "failed" state, your unit **will not** start. Or, if both
  were being started in parallel, your unit will be stopped.

In both cases, `Wants=` and `Requires=` cause systemd to include the dependent unit in
the same transaction. The difference lies in how failure is handled.

## Reverse Dependencies

The `WantedBy=` and `RequiredBy=` directives let you define a dependency **from another
unit back to yours** — effectively reversing the dependency direction.

These directives cause symbolic links to be created. For example, if your unit
specifies:

```ini
WantedBy=multi-user.target
```

systemd creates a symlink:

```
/etc/systemd/system/multi-user.target.wants/my-service.service → /usr/lib/systemd/system/my-service.service
```

This ensures your unit starts during the activation of `multi-user.target`.

### What’s up with the `[Install]` section?

You may have noticed that `Wants=` and `Requires=` appear in the `[Unit]` section of a
unit file, while `WantedBy=` and `RequiredBy=` belong in the `[Install]` section. Why?
And what does "install" even mean here?

The `[Install]` section defines what happens when you **enable** a unit (i.e., configure
it to auto-start at boot). So when you run:

```bash
systemctl enable tailscaled.service
```

systemd reads the `[Install]` section, finds the `WantedBy=multi-user.target`, and adds
the Tailscale service to the dependency list of the `multi-user.target` unit.

This is how auto-starting works: systemd already plans to activate `multi-user.target`
during every boot process, and since Tailscale is now included as a dependency, the
service starts along with it.

> **Note:** The `[Install]` section has no effect until you enable the service. Before
> enabling, the unit exists, but the dependency relationship isn’t set up.

## Why You Need `Before=` and `After=`

**Important:** `Wants=`, `Requires=`, and similar directives do **not** control startup
order. They ensure that certain units are started _together_ in the same transaction,
but not necessarily in any particular sequence. systemd may still start your unit in
parallel with its dependencies.

If you need your unit to start only _after_ another unit has reached an active (or
failed) state, you must explicitly use `After=`. Similarly, if your unit must start
_before_ another, use `Before=`.

Also note: `Before=` and `After=` do **not** imply a dependency. If systemd wasn’t
already planning to start the referenced unit, these directives have no effect. They
only matter when the other unit is part of the current activation transaction.

That’s why `Wants=` or `Requires=` are often paired with `After=`. In most real-world
cases, you need both:

* A **dependency** (to pull the other unit into the current transaction),
* And an **ordering constraint** (to control when it starts during the transaction).

## The Tailscale Example

In the Tailscale example, you see this:

```ini
[Unit]
Wants=network-pre.target
After=network-pre.target NetworkManager.service systemd-resolved.service
```

Here’s what this configuration does:

* `Wants=network-pre.target`: Tailscale will start alongside `network-pre.target`. If,
  for some reason, you manually start `tailscaled.service` and `network-pre.target`
  hasn’t been activated yet, systemd will try to activate it (and its dependencies)
  as well.
  * If `network-pre.target` fails, that’s acceptable — Tailscale still starts, because
    it’s a soft dependency.
* `After=...`: Ensures Tailscale starts only _after_ `network-pre.target`,
  `NetworkManager.service`, and `systemd-resolved.service` have reached a final state
  (either "active" or "failed").

Notice that `NetworkManager.service` and `systemd-resolved.service` are not
listed in `Wants=`. That’s because Tailscale doesn’t want to _depend_ on them —
Tailscale can move mountains to [handle all kinds of Linux DNS and networking configurations](https://tailscale.com/blog/sisyphean-dns-client-linux).
The unit file only ensures the Tailscale service starts after those services, **if**
they are part of the current activation sequence.

You’ll also see this:

```ini
[Install]
WantedBy=multi-user.target
```

This means that when `multi-user.target` is activated (e.g., at boot), systemd will
also start `tailscaled.service` — but only if you’ve previously run `systemctl enable
tailscaled.service`.

## Summary

| Directive     | Section     | Purpose                                                   |
| ------------- | ----------- | --------------------------------------------------------- |
| `Wants=`      | `[Unit]`    | Soft dependency: start together, ignore failure           |
| `Requires=`   | `[Unit]`    | Hard dependency: start together, fail if dependency fails |
| `Before=`     | `[Unit]`    | Start this unit before the listed ones                    |
| `After=`      | `[Unit]`    | Start this unit after the listed ones                     |
| `WantedBy=`   | `[Install]` | Enable auto-start by adding to another unit’s wants       |
| `RequiredBy=` | `[Install]` | Same, but with hard dependency                            |

**Rules of thumb**:

For most cases...

* Use `Wants=` + `After=` together when you want a service to start after another
  service or target.
* Add `WantedBy=multi-user.target` in the `[Install]` section for services that you want
  to auto-start on boot.
