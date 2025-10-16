---
title: tmpshell
date: 2025-10-16T04:49:59+00:00
---

I wrote a [handy fish function](https://github.com/pcrockett/lappy/blob/37f852c69ac68037011bc016d90782f2a16e827d/config/fish/functions/tmpshell.fish)
for those times when you just want to go to a temporary directory, mess with some files
and environment variables, and then clean up afterward:

```
# in ~/.config/fish/functions/tmpshell.fish
function tmpshell
  set temp_dir (mktemp --directory)
  cd $temp_dir
  echo "Run `exit` when finished"
  fish
  cd -
  rm -rf $temp_dir
  echo "Cleaned up $temp_dir"
end
```

Here's what an interactive session looks like:

```
.config/fish/functions on  main [!]
❯ tmpshell
Run `exit` when finished
direnv: unloading

/tmp/tmp.rkxc5HRMOM
❯ echo "foo" > foo.txt

/tmp/tmp.rkxc5HRMOM
❯ exit
Cleaned up /tmp/tmp.rkxc5HRMOM

.config/fish/functions on  main [!] took 6s
❯
```
