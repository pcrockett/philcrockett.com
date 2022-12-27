---
title: Trying OCaml
date: 2022-12-27T18:44:34+00:00
---

I used my [list of requirements for a "dream" programming language](/notes/2022/12/17/dream-programming-language/) to
create a spreadsheet. I use that spreadsheet to calculate a score for each language based on how well it fits my list
of requirements.

Two languages so far score the highest:

## Gleam

{% newTabLink "Gleam" "https://gleam.run/" %} is _so close_ to what I'm looking for. It only misses one mark: native
executables.

Well, it also misses the _object capabilities_ requirement, but almost all other languages miss that feature as well.
The few languages that have object capabilities are all in the experimental stage.

Anyway, Gleam runs on the Erlang VM or compiles to JavaScript, which is a showstopper for the kind of little hobby
command line programs I want to write. However if I ever decide to create a service that can be deployed to a server,
I'll be super excited to try out Gleam.

## OCaml

The next best contender I could find for the kind of software I want to write is {% newTabLink "OCaml" "https://ocaml.org/" %}.
I must say, I have never enjoyed writing / over-engineering {% newTabLink "a hello world program" "https://github.com/pcrockett/hello-ocaml/" %}
so much. The language does sadly use exceptions for error handling, though thankfully exceptions are no longer
considered idiomatic.

I'm going to continue playing with it. We'll see where this goes.

{% mastodonCommentsSection "https://fosstodon.org/@pcrock/109587202658507764" %}
