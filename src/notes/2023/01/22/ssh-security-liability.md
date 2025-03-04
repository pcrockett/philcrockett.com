---
title: "SSH: Security Liability?"
date: 2023-01-22T11:30:33+00:00
lastUpdated: 2025-03-04
---

SSH is pretty handy. As a hobbyist who actually _enjoys_ managing a few Linux boxes, I
use it all the time. However I can't shake the feeling that it's a significant security
liability for a server administrator, despite the fact that the first S in SSH stands
for "secure."

It has too much in common with projects like [PGP / GPG][gpg] and OpenVPN, which:

* were designed a _long_ time ago
* have huge C / C++ codebases
* are difficult to understand, configure, and use correctly
* make it really difficult to [fall into the pit of success][pit]

After all, if you need [configuration auditing software][audit] and a myriad of
"hardening" guides on the Internet, then it just might be too complex.[^1]

[audit]: https://github.com/jtesta/ssh-audit

[gpg]: https://latacora.micro.blog/2019/07/16/the-pgp-problem.html

[pit]: https://blog.codinghorror.com/falling-into-the-pit-of-success/

[^1]: Though to be fair, you could make _exactly_ the same arguments about the Linux
    kernel or any Linux distribution. I'm not 100% sure why I give the operating
    system a pass, while being skeptical of SSH 🤔.

## Learning From WireGuard

I'm not aware of any widely-used alternatives that are secure. But if the [WireGuard][wg]
developers ever come up with something, it'll probably be exactly what I'm looking for.

> WireGuard has been designed with ease-of-implementation and simplicity in mind. It
> is meant to be easily implemented in very few lines of code, and easily auditable for
> security vulnerabilities.

A great example of this is how WireGuard approaches versioning, which is exactly the
opposite of PGP, OpenVPN, and SSH:

> WireGuard restricts the options for implementing cryptographic controls, limits the
> choices for key exchange processes, and maps algorithms to a small subset of modern
> cryptographic primitives. If a flaw is found in any of the primitives, a new version
> can be released that resolves the issue.

<small>[From Wikipedia][wg-wiki]</small>

[wg]: https://www.wireguard.com/

[wg-wiki]: https://en.wikipedia.org/wiki/WireGuard

## What I Do

I don't bother with SSH configuration on my servers anymore. Instead, I rely on
[Tailscale][ts] (which uses WireGuard) to connect to my servers. My firewall only allows
SSH access via the Tailscale interface. At this point I could _almost_ discard SSH
entirely and use [Telnet][telnet] instead (though I don't).[^2]

Of course I have the luxury of being a self-hosted hobbyist, so I don't have a very
complex threat model, and this works well for me. I doubt if the same strategy would be
feasible for someone who needed to [manage a bunch of servers at scale][big-ssh].

[ts]: https://tailscale.com/

[telnet]: https://en.wikipedia.org/wiki/Telnet

[big-ssh]: https://goteleport.com/blog/how-uber-netflix-facebook-do-ssh/

[tv]: https://www.leviathansecurity.com/blog/tunnelvision

[^2]: Splitting things into separate independent pieces (VPN + Telnet) would be a step
    backward. See [TunnelVision][tv] for an example of how this can go wrong. It would
    be really cool if someone built an _**integrated**_ SSH-like remote control mechanism
    where the transport was basically WireGuard.

{% mastodonCommentsSection "<https://fosstodon.org/@pcrock/109732805093391136>" %}
