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
