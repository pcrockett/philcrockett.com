---
title: PIPESTATUS
date: 2025-10-20T16:27:54+00:00
---

---

**tl;dr:** Bash's `$PIPESTATUS` allows you to inspect the exit code of every command in
a pipeline.

---

According to Bash's manpage, `$PIPESTATUS` is...

> An array variable... containing a list of exit status values from the commands in
> the most-recently-executed foreground pipeline, which may consist of only a simple
> command.... Bash sets PIPESTATUS after executing multi-element pipelines, timed and
> negated pipelines, simple commands, subshells created with the ( operator, the [[ and
> (( compound commands, and after error conditions that result in the shell aborting
> command execution.

So it's almost like `$?` on steroids. Especially useful when using the [`yes` command](https://man.archlinux.org/man/yes.1.en).

For example:

```bash
set -o pipefail
yes | some_interactive_command
```

If `some_interactive_command` closes its stdin stream while `yes` is trying to write to
it (which is not uncommon), `yes` will exit with an exit code of 141. Since we ran `set
-o pipefail`, that will crash the script (even though `some_interactive_command` may
have exited with code 0 "success").

Let's modify the script a bit:

```bash
set -o pipefail
yes | some_interactive_command || {
  echo "Exited with code $?"
}
```

This allows the script to keep running, but... sadly it reports the exit code of `yes`,
rather than `some_interactive_command`.

> Exited with code 141

That's almost never what you want. Nobody cares about `yes`. We only care about the
interactive command.

```bash
set -o pipefail
yes | some_interactive_command || {
  echo "Programs in the pipeline exited with these exit codes: ${PIPESTATUS[*]}"
}
```

Here we'll see this output:

> Programs in the pipeline exited with these exit codes: 141 0

* `yes` exited with code 141
* `some_interactive_command` exited with code 0

So taking it just one step further...

```bash
set -o pipefail
yes | some_interactive_command || {
  echo "Exited with code ${PIPESTATUS[1]}"
}
```

> Exited with code 0

That's more like it. Now we're looking at the exit code of the command we actually care
about. Putting it in a real-world script could look something like this:

```bash
set -o pipefail

panic() {
  echo "$*" >&2
  exit 1
}

yes | some_interactive_command || {
  result=${PIPESTATUS[1]}
  test ${result} -eq 0 || panic "some_interactive_command exited with code ${result}"
}
```
