# How to contribute

First off, thank you for taking the time to check out how to contribute! It is
greatly appreciated.  You can contribute with [code], [documentation], [bug
reports], [discussion] and [ideas and feature requests].

 [code]:#contribute-with-code
 [documentation]:#contribute-with-documentation
 [bug reports]:#bug-reports
 [ideas and feature requests]:#contribute-with-ideas
 [discussion]:#contribute-with-discussion

If you need more in depth information about how exactly you can get started,
head to the wiki. There is an article under construction that'll help you with
contributing towards your first issue, from beginning to end.

## Bug reports

Good bug reports go a long way to make this library more stable and easy to use
for anyone. If you spot a bug, please *do* report it, but also include the
following information to make it easier to reproduce the issue:

 - Your Erlang/OTP and Elixir version.
 - Your OS and version.
 - The version (or commit SHA) of Crutches.

Before reporting a bug, please also check:

 - If the issue has been reported before. Don't worry if you're not 100% sure,
   we prefer dealing with duplicate issues than unreported bugs.
 - If it has been fixed in `master`.

## Contribute with code

 - Choose an issue to implement. Issues are marked on their perceived difficulty
   level. Comment on it, letting the others know you are working on it.
 - Fork this repository and clone your fork to your local machine!
 - Create a new branch with a descriptive name.
 - Follow the instructions on the issue. Adapt the function documentation you
   find in the issue to the Elixir format (ExDoc). Be sure to add the doctests.
 - Write the code to make the tests pass. You can check this by typing `mix test`
   in your shell.
 - Commit, push and open a Pull Request!

### Bonus points

Extra internet points are awarded for the following things. These are not
necessary, but they improve the quality of the code and the overall quality
of this repository.

 - Try to follow the [Elixir style guide].
 - Use `git`'s interactive rebase tool before submitting a Pull Request to
   squash the commits into a single commit.
 - Rebase the `master` branch into your own, ensuring that your changes can
   be merged cleanly.
 - Write a [proper commit message].
 - Provide documentation with your implementation.

 [proper commit message]:https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
 [Elixir style guide]:https://github.com/niftyn8/elixir_style_guide

## Contribute with documentation

Documentation is a first class citizen in Elixir. So treat it like a first class
citizen! If you see a general lack of documentation, or you simply want to
contribute but you are not still able to write Elixir code, you could always
improve the documentation.

If you want some pointers for places that the documentation could be improved
upon, check the [Inch CI page] of the project. Anything below an A might
need some work.

 [Inch CI page]:http://inch-ci.org/github/mykewould/crutches

## Contribute with ideas

You don't see an issue about a method that should be implemented and that could
be helpful for anyone? Open an issue! Issues are very welcome because help the
growth of this library.

If you don't know where to start, you can get some ideas from 
[Active Support features]:https://github.com/mykewould/crutches/blob/master/active-support.md

## Contribute with discussion

This contribution is perhaps the most important. Reply to issue! Give your
opinion! If you cannot contribute with code, you can _always_ contribute with
your opinion.
