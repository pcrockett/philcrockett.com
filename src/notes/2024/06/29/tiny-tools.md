---
title: Tiny Tools
date: 2024-06-29T05:09:20+00:00
---

A couple years ago I wrote about [what I want in a programming language](/notes/2022/12/17/dream-programming-language/).
I then decided to [try OCaml](/notes/2022/12/27/trying-ocaml/) even though it was missing a few
important points in my list of requirements for a "dream language." I never took OCaml much farther
than an over-engineered Hello World test run, though I did generally enjoy the experience.

I was looking for a good load-bearing language -- something that scales well, makes a large codebase
easy **and** enjoyable to maintain, and which you could use to build big tools or systems with. In
hindsight, I should have been looking for a language that makes it easy and fun to create _tiny
tools_. Since I have a small child and other priorities, I don't have too much time or energy to
build big things, and I'm ok with that.

Which is why since then I have mostly been enjoying Bash and Nushell.

## Nushell

I don't recommend [Nushell](https://www.nushell.sh/) as your day-to-day interactive shell (yet). But
writing small scripts in Nushell is insanely fun. I like the syntax, type safety, functional style.
I like the polish around displaying things, parameter parsing, help messages, and JSON parsing. I
like how it encourages you to create a sort of well-defined data flow and transformation pipeline in
your scripts.

It makes me happy.

But I really only use it for personal scripts, because it hasn't reached a stable 1.0 yet and not
many people have it installed. I've also had trouble using it seriously with programs like
[fzf](https://github.com/junegunn/fzf), which I also love.

So for everything else, there's...

## Bash? srsly?

I never thought I would say this, but Bash is actually _really fun_. I've gotten quite good at it.
Don't get me wrong: It is a terrible, horrible, no-good language for _a lot_ of use cases. But it
is still incredibly good at gluing bigger programs together in interesting ways with very few lines
of code.

It's also _shippable_ -- I can publish Bash scripts with an open source license, and other people
might actually benefit from them. I've developed a certain style in writing Bash that makes the
code surprisingly bearable to read, more robust, and avoids a lot of common landmines.

In other words, Bash allows me to leverage other people's hard work with load-bearing languages to
solve my own problems using just a few lines of code.

## I'll write more

I'm trying to keep these posts short, and my son is starting to wake up. I'm gonna go hang out with
him. Perhaps later I'll write a followup post about some of my Bash projects (which are mostly
published on GitHub) and some of the tools I find to be indispensable for making nice CLIs and
TUIs.

{% mastodonCommentsSection "<https://fosstodon.org/deck/@pcrock/112698356732753269>" %}
