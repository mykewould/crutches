This is an exhaustive list of [Active Support Core Extensions][1] features, it
intends to act as a discussion trigger on possible Crutches features.

Many of this features **probably** will be added to Crutches, others just don't
as this library doesn't intend to be a clone of Active Support.

Legend:
* [x] Implemented in Crutches
* [x] ~~Implemented in Elixis standar lib~~

Active Support features
=======================

* [ ] Extensions to all objects
  * [ ] blank and present
  * [ ] presence
  * [ ] duplicable
  * [ ] deep_dup
  * [ ] try
  * [ ] class_eval
  * [ ] acts_like
  * [ ] to_param
  * [ ] to_query
  * [ ] with_options
  * [ ] to_param
  * [ ] JSON support
  * [ ] instance_values
  * [ ] instance_variable_names
  * [ ] silence_warnings
  * [ ] silence_streams
  * [ ] quietly
  * [ ] supress
  * [ ] in


* [ ] Extensions to Module
 * [ ] alias_method_chain
 * [ ] alias_attribute
 * [ ] `attr_internal_*`
 * [ ] mattr_*
 * [ ] parent
 * [ ] parent_name
 * [ ] parents
 * [ ] local_constants
 * [ ] `qualified_const_*`
 * [ ] reachable
 * [ ] anonymous
 * [ ] delegate
 * [ ] redefine_method


* [ ] Extensions to Class
 * [ ] class_attribute
 * [ ] cattr_*
 * [ ] subclasses
 * [ ] descendants


* [ ] Extensions to String
 * [ ] output safety
 * [x] remove
 * [x] squish
 * [x] truncate
 * [ ] truncate_words
 * [ ] inquiry
 * [x] ~~starts_with / ends_with~~
 * [ ] strip_heredoc
 * [ ] indent
 * [x] ~~at~~
 * [x] from
 * [x] to
 * [x] ~~first~~
 * [x] ~~last~~
 * [ ] pluralize
 * [ ] singularize
 * [x] camelize
 * [x] underscore
 * [ ] titleize
 * [ ] dasherize
 * [ ] demodulize
 * [ ] deconstantize
 * [ ] parameterize
 * [ ] tableize
 * [ ] classify
 * [ ] constantize
 * [ ] humanize
 * [ ] foreign_key
 * [ ] to_date, to_time, to_datetime


* [ ] Extensions to Numeric
 * [ ] bytes
 * [ ] time
 * [x] formatting


* [ ] Extensions to Integer
 * [x] multiple_of
 * [ ] ordinal
 * [ ] ordinalize


* [ ] Extensions to BigDecimal
 * [ ] to_s (alias of to_formatted_s)
 * [ ] to_formatted_s


* [ ] Extensions to Enumerable
 * [ ] sum
 * [ ] index_by
 * [x] many
 * [x] exclude

* [ ] Extensions to Array
 * [x] to
 * [x] from
 * [ ] accesing (second, third, fourth, fifth)
 * [ ] prepend
 * [ ] append
 * [ ] extract_options
 * [ ] to_sentence
 * [ ] to_formatted_s
 * [ ] to_xml
 * [x] ~~wrap~~
 * [ ] deep_dup
 * [ ] in_groups_of
 * [x] in_groups
 * [x] split

* [ ] Extensions to Hash
 * [ ] to_xml
 * [ ] reverse_merge
 * [ ] reverse_update (alias reverse_merge!)
 * [ ] deep_merge
 * [ ] deep_dup
 * [x] ~~except~~
 * [ ] transform_keys
 * [x] deep_transform_keys
 * [ ] stringify_keys
 * [ ] symbolize_keys
 * [ ] to_options (alias symbolize_keys)
 * [ ] assert_valid_keys
 * [ ] transform_values
 * [x] ~~slice~~
 * [x] ~~extract~~
 * [ ] with_indifferent_access
 * [ ] compact


* [ ] Extensions to Regexp
 * [ ] multiline

* [ ] Extensions to Range
 * [ ] to_s
 * [ ] include
 * [x] overlaps


* [ ] Extensions to Date
 * [ ] current
 * [ ] prev_year, next_year
 * [ ] prev_month, next_month
 * [ ] prev_quarter, next_quearter
 * [ ] prev_week, next_week
 * [ ] beginning_of_year, end_of_year
 * [ ] beginning_of_week, end_of_week
 * [ ] beginning_of_month, end_of_month
 * [ ] beginning_of_quarter, end_of_quarter
 * [ ] beginning_of_day, end_of_day
 * [ ] beginning_of_hour, end_of_hour
 * [ ] beginning_of_minute, end_of_minute
 * [ ] monday, sunday
 * [ ] years_ago, years_since
 * [ ] months_ago, months_since
 * [ ] weeks_ago, weeks_since
 * [ ] advance
 * [ ] change
 * [ ] duration (add, subtract)
 * [ ] ago, since


* [ ] Extensions to DateTime
 * [ ] inherited methods from Date
 * [ ] seconds_since_midnight
 * [ ] utc
 * [ ] utc?

* [ ] Extensions to Time
 * [ ] inherited methods from DateTime
 * [ ] all_day, all_week, all_month, all_quarter and all_year


* [ ] Extensions to File
 * [ ] atomic_write


* [ ] Extensions to Marshall
 * [ ] load


* [ ] Extensions to Logger
 * [ ] around_*
 * [ ] silence
 * [ ] datetime_format


* [ ] Extensions to NameError
 * [ ] missing_name


* [ ] Extensions to LoadError
 * [ ] is_missing

[1]: http://guides.rubyonrails.org/active_support_core_extensions.html
