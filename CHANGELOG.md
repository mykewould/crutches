# Change Log
All notable changes to Crutches will be documented in this file.

## [Unreleased](https://github.com/mykewould/crutches/tree/HEAD)

[Full Changelog](https://github.com/mykewould/crutches/compare/v0.0.4...HEAD)

## [0.0.5] - 2015-08-25

**Implemented enhancements:**

- Convert Crutches.Helpers.Number.number\_to to Crutches.Format.Number.as\_ [\#45](https://github.com/mykewould/crutches/issues/45)

**Closed issues:**

- Crutches.Range.overlaps? [\#73](https://github.com/mykewould/crutches/issues/73)
- Integer.ordinal/ordinalize =\> Format.Integer.ordinal/ordinalize? [\#70](https://github.com/mykewould/crutches/issues/70)
- List.to\_sentence =\> Format.List.as\_sentence? [\#69](https://github.com/mykewould/crutches/issues/69)
- Crutches.String.truncate [\#63](https://github.com/mykewould/crutches/issues/63)
- Make use of Option.combine instead of Option.validate! [\#56](https://github.com/mykewould/crutches/issues/56)
- Renaming Number.number\_to\_XYZ to Number.format\_as\_XYZ [\#44](https://github.com/mykewould/crutches/issues/44)
- Options.combine! [\#42](https://github.com/mykewould/crutches/issues/42)
- Crutches.Format.to\_json [\#31](https://github.com/mykewould/crutches/issues/31)
- Crutches.Format.to\_xml [\#30](https://github.com/mykewould/crutches/issues/30)
- number\_to\_phone [\#28](https://github.com/mykewould/crutches/issues/28)
- Crutches.Format.Number.as\_percentage [\#27](https://github.com/mykewould/crutches/issues/27)
- Crutches.Format.Number.as\_human [\#25](https://github.com/mykewould/crutches/issues/25)
- Crutches.Format.Number.as\_currency [\#23](https://github.com/mykewould/crutches/issues/23)
- Wiki Design: Discussion [\#22](https://github.com/mykewould/crutches/issues/22)
- Got an idea? [\#20](https://github.com/mykewould/crutches/issues/20)
- Array\#in\_groups =\> List.in\_groups [\#12](https://github.com/mykewould/crutches/issues/12)
- Array\#to\_xml =\> List.to\_xml [\#7](https://github.com/mykewould/crutches/issues/7)

**Merged pull requests:**

- Added some Crutches.Range functions. [\#74](https://github.com/mykewould/crutches/pull/74) ([jdl](https://github.com/jdl))
- Moved Integer.ordinal/ordinalize to Format.Integer \(\#70\) [\#71](https://github.com/mykewould/crutches/pull/71) ([knrz](https://github.com/knrz))
- Inefficient List.shorten [\#66](https://github.com/mykewould/crutches/pull/66) ([lpil](https://github.com/lpil))
- Added String.truncate [\#65](https://github.com/mykewould/crutches/pull/65) ([knrz](https://github.com/knrz))
- As rounded [\#64](https://github.com/mykewould/crutches/pull/64) ([knrz](https://github.com/knrz))
- Dependencies cleanup [\#62](https://github.com/mykewould/crutches/pull/62) ([druzn3k](https://github.com/druzn3k))
- implemented Number\#as\_human [\#61](https://github.com/mykewould/crutches/pull/61) ([druzn3k](https://github.com/druzn3k))
- Crutches.Format.Number refactoring [\#60](https://github.com/mykewould/crutches/pull/60) ([druzn3k](https://github.com/druzn3k))
- Add Number.as\_percentage function [\#59](https://github.com/mykewould/crutches/pull/59) ([Axxiss](https://github.com/Axxiss))
- Add CHANGELOG.md [\#58](https://github.com/mykewould/crutches/pull/58) ([duijf](https://github.com/duijf))
- Refactor `as\_delimited` [\#57](https://github.com/mykewould/crutches/pull/57) ([duijf](https://github.com/duijf))
- Correct markdown links [\#55](https://github.com/mykewould/crutches/pull/55) ([doomspork](https://github.com/doomspork))
- Add Travis webhook [\#54](https://github.com/mykewould/crutches/pull/54) ([duijf](https://github.com/duijf))
- \[23\] Format.Number includes \#as\_currency function [\#51](https://github.com/mykewould/crutches/pull/51) ([jesuspc](https://github.com/jesuspc))
- Fixed typo [\#50](https://github.com/mykewould/crutches/pull/50) ([caryanne](https://github.com/caryanne))
- Feature/fix integer ordinal [\#49](https://github.com/mykewould/crutches/pull/49) ([joeyates](https://github.com/joeyates))
- Recursive key change for Maps [\#48](https://github.com/mykewould/crutches/pull/48) ([mykewould](https://github.com/mykewould))
- converted Crutches.Helpers.Number in Crutches.Format.Number [\#46](https://github.com/mykewould/crutches/pull/46) ([druzn3k](https://github.com/druzn3k))
- WIP Crutches.Option module [\#43](https://github.com/mykewould/crutches/pull/43) ([duijf](https://github.com/duijf))
- WIP Dialyzer fixes [\#41](https://github.com/mykewould/crutches/pull/41) ([duijf](https://github.com/duijf))
- Improve the project's general documentation [\#39](https://github.com/mykewould/crutches/pull/39) ([duijf](https://github.com/duijf))
- \[28\] The default mechanism for option resolution is used now at Helpe… [\#38](https://github.com/mykewould/crutches/pull/38) ([jesuspc](https://github.com/jesuspc))
- Improved Project Documentation [\#37](https://github.com/mykewould/crutches/pull/37) ([druzn3k](https://github.com/druzn3k))
- \[28\] Number helper includes now a number\_to\_phone\2 function [\#35](https://github.com/mykewould/crutches/pull/35) ([jesuspc](https://github.com/jesuspc))
- Implemented List\#in\_groups [\#33](https://github.com/mykewould/crutches/pull/33) ([druzn3k](https://github.com/druzn3k))


## [0.0.4] - 2015-07-26
### Added
- `List.shorten/2`, [#11](https://github.com/mykewould/crutches/pull/11)
- `List.to/2`, [#14](https://github.com/mykewould/crutches/pull/14)
- `List.split/2`, [#14](https://github.com/mykewould/crutches/pull/14)
- `Integer.ordinal/1` and `Integer.ordinalize/1`,
  [#18](https://github.com/mykewould/crutches/pull/18)
- `Enum.many/1`, [#18](https://github.com/mykewould/crutches/pull/18)
- `Integer.multiple_of?/2`, [#18](https://github.com/mykewould/crutches/pull/18)
- `Keyword.all_keys_valid?/2`, [#21](https://github.com/mykewould/crutches/pull/21)
- `Keyword.validate_keys/2` and `Keyword.validate_keys!/2`, [#21](https://github.com/mykewould/crutches/pull/21)
- Travis and Inch Continuous Integration suites and badges

### Fixed
- Tests for the `Crutches.String` module,
  [#14](https://github.com/mykewould/crutches/pull/14)

### Changed
- Refactor of `List.to_sentence/2`
- Ask contributors to let others know when they are working on something in the
  REAMDE.
- `List.without/2` is now `Enum.without/2`,
  [#18](https://github.com/mykewould/crutches/pull/18)
- Remove list of functions in the README to Hexdocs.

## [0.0.3] - 2015-07-17
### Added
- `List` module and `Crutches.List.without/2`,
  [#8](https://github.com/mykewould/crutches/pull/8)
- `List.from/2`, [#9](https://github.com/mykewould/crutches/pull/9)
- `List.to_sentence`, [#10](https://github.com/mykewould/crutches/pull/10)
- `String.to/2`
- `String.squish/1`
- `String.remove/2`

### Changed
- Added a license notice to the REAMDE (MIT)
- Added sales pitch and contributors notice to the README.

## [0.0.2] - 2015-06-26
### Added
- `String.from/2`
- `String.camelize/1`

## 0.0.1 - 2015-06-26
### Added
- A new Elixir project skeleton
- `String` module for functions pertaining to operations on Elixir's
  String type.
- `String.underscore/1`

[0.0.4]: https://github.com/mykewould/crutches/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/mykewould/crutches/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/mykewould/crutches/compare/v0.0.1...v0.0.2

\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
