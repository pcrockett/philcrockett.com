---
title: My Dream Programming Language
date: 2022-12-17
---

I'm on the hunt for a fun programming language that I can pick up and mess with in my free time. I have a few fairly
usual requirements that a lot of people ask for, plus a few less common requirements.

The "normal" requirements:

* Compiles to native, dependency-free executable
    * I could compromise on this if it were a small scripting language
* Functional programming paradigm (primarily)
* Robust type system
* Intuitive / enjoyable syntax
* Reasonable learning curve
    * While I like Rust, I'm looking for something [with lower standards][rust-downsides]
* Reasonably efficient performance
* Open source
* Runs well on Linux (cross-platform a bonus)

The more niche requirements:

* Uses [object capabilities][pony-caps]
    * no more static / global APIs for file, network, and other resources
    * encourages [dependency injection][di] instead
* [Result types][rust-result] instead of exceptions
* [Option types][rust-option] instead of nulls
* Related to the above two points: robust [pattern matching][rust-matching]
* Doesn't require a heavyweight IDE for everything

I don't think this programming language exists as of 2022. If it does, do [let me know](/contact/)!

[pony-caps]: https://tutorial.ponylang.io/reference-capabilities/index.html
[rust-result]: https://doc.rust-lang.org/std/result/
[rust-option]: https://doc.rust-lang.org/std/option/
[rust-matching]: https://doc.rust-lang.org/book/ch18-03-pattern-syntax.html
[di]: https://en.wikipedia.org/wiki/Dependency_injection
[rust-downsides]: https://mdwdotla.medium.com/using-rust-at-a-startup-a-cautionary-tale-42ab823d9454