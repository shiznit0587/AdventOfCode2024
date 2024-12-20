# Day 8

I added some operator overrides to the shared `Coords` type.

# Day 7

At first I tried to use `^` as a power operator, oops.

I finally used an optional positional argument. Syntax for these, and for named optional arguments, is interesting here.

I tried to make the `Operator` enum contain a member for the lambda to apply itself, but the compiler was really unhappy, said the functions weren't compiler constants.

I'm happy with the optimizations on this one.
- I track the equations that fail part 1 and only evaluate those in part 2.
- I cache lists of operations based on the count of numbers, to reduce repeated work.
- For part 2, I also only test lists of operations that contain the new operator.

No matter what I tried, I could not implement `buildOperatorLists` as a `sync*` method. It kept causing a stack overflow, when the same code terminates perfectly fine when written regularly.

# Day 6

I commonized a bunch of code from Day 4 into `shared.dart` for use with Day 6 as well.

Part 2 was originally taking 7s to run. I got CPU profiling working. Then I was clued in on an optimization to only try placing obstructions along the path from Part 1, which brought the runtime down to 1.7s. I'm still not satisfied with it, but it's enough to move on for now.

I tried writing my own hashCode getter for `Knight`, but it actually made things slower.

# Day 5

It was really annoying that the post-increment operator doesn't work with a map indexer.
- `map[i]++` needs to be `map[i] = map[i]! + 1`

With some iterating after having a solution, I found the collection of [`quiver`](https://pub.dev/packages/quiver) libraries from google, stuff that's nice to have when you need it but too niche to be included in the core libraries. I updated to use a `Multimap`.

From the diagnostic [`prefer_for_elements_to_map_fromiterable`](https://dart.dev/tools/diagnostic-messages#prefer_for_elements_to_map_fromiterable), I learned dart has a `for element`, like haxe (and python, iirc).

Named arguments are a neat syntax for extending a method signature cleanly. Reminds me of Objective-C a bit. Also makes sense that they're needed, since dart doesn't have method overloading.

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
