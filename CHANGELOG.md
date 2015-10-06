# CHANGELOG

All notable changes made to Crutches will be documented in this file.

## [1.0.0] - 2015-10-05

### Added

 - `Format.Number.as_human_size/2`, [#77], ([druzn3k])
 - Add ActiveSupport feature list, [#80], ([Axxiss])

### Enhanced

 - Add documentation for `List.in_groups/3`, `Crutches.Format.List` and
   `Crutches.Integer`, [#79], ([druzn3k])

### Changed

 - Delegate `String.camelize/1` and `String.underscore/1` to `Mix.Utils`, [#68],
   ([druzn3k])
 - Test against Elixir v1.1.0, [`37d466f6`][37d466f6], ([duijf])
 - Reformat `CHANGELOG.md`, ([duijf])

### Fixed

 - `__using__` macro in main module, [`8e933327`][8e933327], ([duijf])

## [0.0.5] - 2015-08-25

### Added

 - `Range.overlaps?/2`, [#74], ([jdl])
 - `Range.intersection/2`, [#74], ([jdl])
 - `Range.union/2`, [#74], ([jdl])
 - `String.truncate/1`, [#65], ([knrz])
 - `Option` module, [#43], ([duijf])
 - `Format.Number.as_rounded/2`, [#64], ([knrz])
 - `Format.Number.as_human/2`, [#61], ([druzn3k])
 - `Format.Number.as_percentage/2`, [#59], ([Axxiss])
 - `Format.Number.as_currency/2`, [#51], ([jesuspc])
 - `Format.Number.as_phone/2`, [#35], ([jesuspc])
 - `CHANGELOG.md`, [#58], ([duijf])
 - Added Gitter webhook to Travis, [#54], ([duijf])
 - `Map.deep_key_change/2`, [#48], ([mykewould])
 - `List.in_groups/4`, [#33], ([druzn3k])

### Enhanced

 - `List.shorten` performance enhancements, [#66], ([lpil])
 - `Format.Number.as_delimited` refactor, [#57], ([duijf])
 - Project documentation, [#37], [#39], ([druzn3k], [duijf])

### Changed

 - `Integer.ordinal` =\> `Format.Integer`, [#70], ([knrz])
 - `List.to_sentence` =\> `Format.List.as_sentence?`
 - `Keyword.*` =\> `Option.*`, [#43], ([duijf])
 - `Helpers.Number` =\> `Format.Number`, [#46], ([druzn3k])
 - `Integer.*` =\> `Format.Integer.*`, [#71], ([knrz])
 - Dependencies cleanup, [#62], ([druzn3k])
 - `Number.*` uses `Option.*`, [#38], ([jesuspc])

### Fixed

 - Fix markdown links in `REAMDE.md`, [#55], ([doomspork])
 - Fix typo in `README.md`, [#50], ([caryanne])
 - Incorrect results in `Integer.ordinal`, [#49], ([joeyates])
 - Dialyzer types, [#41], ([duijf])

## [0.0.4] - 2015-07-26

### Added
- `List.shorten/2`, [#11]
- `List.to/2`, [#14]
- `List.split/2`, [#14]
- `Integer.ordinal/1` and `Integer.ordinalize/1`, [#18]
- `Enum.many/1`, [#18]
- `Integer.multiple_of?/2`, [#18]
- `Keyword.all_keys_valid?/2`, [#21]
- `Keyword.validate_keys/2` and `Keyword.validate_keys!/2`, [#21]
- Travis and Inch Continuous Integration suites and badges

### Fixed
- Tests for the `Crutches.String` module, [#14]

### Changed
- Refactor of `List.to_sentence/2`
- Ask contributors to let others know when they are working on something in the
  REAMDE.
- `List.without/2` is now `Enum.without/2`, [#18]
- Remove list of functions in the README to Hexdocs.

## [0.0.3] - 2015-07-17

### Added
- `List` module and `Crutches.List.without/2`, [#8]
- `List.from/2`, [#9]
- `List.to_sentence`, [#10]
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
- `String` module for functions pertaining to operations on Elixir's String
  type.
- `String.underscore/1`

[lpil]:https://github.com/lpil
[jdl]:https://github.com/jdl
[knrz]:https://github.com/knrz
[duijf]:https://github.com/duijf
[druzn3k]:https://github.com/druzn3k
[jesuspc]:https://github.com/jesuspc
[Axxiss]:https://github.com/Axxiss
[doomspork]:https://github.com/doomspork
[caryanne]:https://github.com/caryanne
[mykewould]:https://github.com/mykewould

[#80]:https://github.com/mykewould/crutches/pull/80
[#79]:https://github.com/mykewould/crutches/pull/79
[#77]:https://github.com/mykewould/crutches/pull/77
[#74]:https://github.com/mykewould/crutches/pull/74
[#73]:https://github.com/mykewould/crutches/issues/73
[#71]:https://github.com/mykewould/crutches/pull/71
[#70]:https://github.com/mykewould/crutches/pull/70
[#68]:https://github.com/mykewould/crutches/pull/68
[#66]:https://github.com/mykewould/crutches/pull/66
[#65]:https://github.com/mykewould/crutches/pull/65
[#64]:https://github.com/mykewould/crutches/pull/64
[#62]:https://github.com/mykewould/crutches/pull/62
[#61]:https://github.com/mykewould/crutches/pull/61
[#59]:https://github.com/mykewould/crutches/pull/59
[#58]:https://github.com/mykewould/crutches/pull/58
[#57]:https://github.com/mykewould/crutches/pull/57
[#55]:https://github.com/mykewould/crutches/pull/55
[#54]:https://github.com/mykewould/crutches/pull/54
[#51]:https://github.com/mykewould/crutches/pull/51
[#50]:https://github.com/mykewould/crutches/pull/50
[#49]:https://github.com/mykewould/crutches/pull/49
[#48]:https://github.com/mykewould/crutches/pull/48
[#46]:https://github.com/mykewould/crutches/pull/46
[#45]:https://github.com/mykewould/crutches/issues/45
[#43]:https://github.com/mykewould/crutches/pull/43
[#41]:https://github.com/mykewould/crutches/pull/41
[#39]:https://github.com/mykewould/crutches/pull/39
[#38]:https://github.com/mykewould/crutches/pull/38
[#37]:https://github.com/mykewould/crutches/pull/37
[#35]:https://github.com/mykewould/crutches/pull/35
[#33]:https://github.com/mykewould/crutches/pull/33
[#21]:https://github.com/mykewould/crutches/pull/21
[#18]:https://github.com/mykewould/crutches/pull/18
[#14]:https://github.com/mykewould/crutches/pull/14
[#11]:https://github.com/mykewould/crutches/pull/11
[#10]:https://github.com/mykewould/crutches/pull/10
[#9]:https://github.com/mykewould/crutches/pull/9
[#8]:https://github.com/mykewould/crutches/pull/8

[37d466f6]:https://github.com/mykewould/crutches/commit/37d466f6a27096187ae20d341a31721079645a23
[8e933327]:https://github.com/mykewould/crutches/commit/8e933327f409368545825b781d97c7415e02a2d9


[1.0.0]: https://github.com/mykewould/crutches/compare/v0.0.5...v1.0.0
[0.0.5]: https://github.com/mykewould/crutches/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/mykewould/crutches/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/mykewould/crutches/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/mykewould/crutches/compare/v0.0.1...v0.0.2
