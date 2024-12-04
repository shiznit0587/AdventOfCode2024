# Day 4

## Part 1

I've now used `late final`, `typedef`, and learned about `Record` types. All handy, but nothing I haven't seen before in C#.

I tried using a `sync*` method with `yield` statements to produce an `Iterable<(int, int)>`, but I realized this wouldn't allow me to maintain the same direction while searching so I abandoned it.

Happy to see that enums can contain values. I don't think they're GADTs though, closer to Java than haxe/ocaml.

I so want to split up the work in parallel. But I think I need more time to digest dart's `Isolates` system. It's the actor model, with each `Isolate` having its own state, with no access to shared state, even finals. It reminds me of working with `mpi` back in the day. I favor Rust's borrow checker over this, I think.

## Part 2

I've found `extension` now. An annonymous extension on a typedef of a record seems overkill, but I rather prefer the terseness of the record creation syntax over calling a constructor.

I've found deconstructing expressions in switch statements! One of my favorite language features.

I wanted to add an extension to `List<String>` that would overload the `operator[]` to take a `Coords`, but it doesn't seem that overloading exists in dart (much like haxe).

# Day 3

- I found the `where`, `map`, and `fold` methods, looks like I can do some standard functional data operations, yay!
- `SplayTreeMap` was a really fun way to build a lookup for whether each `mul` match should be considered for the final result. Similar to Java's `NavigableMap`.

# Day 2

I found the package manager.
- https://pub.dev

The `..` cascade notation is nice. It potentially turns every API into the builder pattern.

I'm sure I can optimize these first two days, both for code length and for runtime. Maybe later.

Added timings for all days and the whole project.

Added `.gitignore`, got uploaded to Github for sharing.

# Day 1

Thoughts:
- regex was easy!
- `!` operator for asserting non-nullness came easy to me too after rust.
- I'm glad to see string interpolation in the language, similar syntax to haxe.
- `async`/`await` is fairly clean, similar to c#.
- I think that's kind of a theme, the language is really just borrowing from a bunch of others in a clean way.
- Finding methods on primitives felt weird, but not out of place.
- Two space indents is going to take some getting used to, but I've seen it before in yaml.

# Project Setup

I tried to use Flutter initially, but the setup was hell.

- I had to install the flutter sdk via brew instead of automatically by vscode due to a hang.
- I had an odd issue where I had to run xcode-select to fix it up.
- I had to move my project from my iCloud drive to be local on the computer, due to security features refusing to run the app because of some extended file metadata attached by iCloud syncing.

In the end, I dropped flutter, and only used dart.
- https://dart.dev/tutorials/server/get-started

# References

- https://dart.dev/overview
- https://dart.dev/language
- https://dart.dev/libraries
- https://dart.dev/server
- https://pub.dev
