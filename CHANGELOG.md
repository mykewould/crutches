# Change Log
All notable changes to Crutches will be documented in this file.

## [Unreleased][unreleased]

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

[unreleased]: https://github.com/mykewould/crutches/compare/v0.0.4...HEAD
[0.0.4]: https://github.com/mykewould/crutches/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/mykewould/crutches/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/mykewould/crutches/compare/v0.0.1...v0.0.2
