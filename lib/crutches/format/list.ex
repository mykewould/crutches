defmodule Crutches.Format.List do
  alias Crutches.Option

  @moduledoc ~S"""
  Formatting helper functions for lists.

  This module contains various helper functions that should be of use to you
  when writing user interfaces or other parts of your application that have
  to deal with lists formatting.

  simply call the desired function with any relevant options that you may need.
  """

  @doc ~S"""
  Converts the array to a comma-separated sentence where the last element is
  joined by the connector word.

  You can pass the following options to change the default behavior. If you
  pass an option key that doesn't exist in the list below, it will raise an
  <tt>ArgumentError</tt>.

  ## Options

  * <tt>:words_connector</tt> - The sign or word used to join the elements
   in arrays with two or more elements (default: ", ").
  * <tt>:two_words_connector</tt> - The sign or word used to join the elements
   in arrays with two elements (default: " and ").
  * <tt>:last_word_connector</tt> - The sign or word used to join the last element
   in arrays with three or more elements (default: ", and ").
  * <tt>:locale</tt> - If +i18n+ is available, you can set a locale and use
   the connector options defined on the 'support.array' namespace in the
   corresponding dictionary file.

  ## Examples

      iex> List.as_sentence([])
      ""

      iex> List.as_sentence(["one"])
      "one"

      iex> List.as_sentence(["one", "two"])
      "one and two"

      iex> List.as_sentence(["one", "two", "three"])
      "one, two, and three"

      iex> List.as_sentence(["one", "two"], passing: "invalid option")
      ** (ArgumentError) invalid key passing

      iex> List.as_sentence(["one", "two"], two_words_connector: "-")
      "one-two"

      iex> List.as_sentence(["one", "two", "three"], words_connector: " or ", last_word_connector: " or at least ")
      "one or two or at least three"
  """
  @as_sentence [
    valid: ~w(words_connector two_words_connector last_word_connector)a,
    defaults: [
      words_connector: ", ",
      two_words_connector: " and ",
      last_word_connector: ", and "
    ]
  ]

  @spec as_sentence(list(any)) :: String.t()
  def as_sentence(words, opts \\ @as_sentence[:defaults])
  def as_sentence([], _), do: ""
  def as_sentence([word], _), do: "#{word}"

  def as_sentence([first, last], opts) do
    opts = Option.combine!(opts, @as_sentence)

    first <> opts[:two_words_connector] <> last
  end

  def as_sentence(words, opts) when is_list(words) do
    opts = Option.combine!(opts, @as_sentence)

    init =
      case Crutches.List.shorten(words) do
        {:ok, shortened_list} -> Enum.join(shortened_list, opts[:words_connector])
        _ -> []
      end

    last = List.last(words)

    init <> opts[:last_word_connector] <> last
  end
end
