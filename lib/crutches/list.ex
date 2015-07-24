defmodule Crutches.List do
  @type t :: List
  @type i :: Integer
  @type a :: any

  @doc ~S"""
  Returns the tail of the array from +position+.

  ## Examples


      iex> List.from(["a", "b", "c", "d"], 0)
      ["a", "b", "c", "d"]

      iex> List.from(["a", "b", "c", "d"], 2)
      ["c", "d"]

      iex> List.from(["a", "b", "c", "d"], 10)
      []

      iex> List.from([], 0)
      []

      iex> List.from(["a", "b", "c", "d"], -2)
      ["c", "d"]

      iex> List.from(["a", "b", "c", "d"], -10)
      []

  """
  @spec from(t, i) :: t
  def from(collection, position) do
    Enum.slice(collection, position, length(collection))
  end

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

      iex> List.to_sentence([])
      ""

      iex> List.to_sentence(["one"])
      "one"

      iex> List.to_sentence(["one", "two"])
      "one and two"

      iex> List.to_sentence(["one", "two", "three"])
      "one, two, and three"

      iex> List.to_sentence(["one", "two"], [{:passing, "invalid option"}])
      ** (ArgumentError) invalid key passing

      iex> List.to_sentence(["one", "two"], [{:two_words_connector, "-"}])
      "one-two"

      iex> List.to_sentence(["one", "two", "three"], [{:words_connector, " or "}, {:last_word_connector, " or at least "}])
      "one or two or at least three"

      Using <tt>:locale</tt> option:

      Given this locale dictionary:

       es:
         support:
           array:
             words_connector: " o "
             two_words_connector: " y "
             last_word_connector: " o al menos "

      iex> es = [support: [array: [words_connector: " o ", two_words_connector: " y ", last_word_connector: " o al menos "]]]
      iex> List.to_sentence(['uno', 'dos'], [{:locale, es}])
      "uno y dos"

      iex> es = [support: [array: [words_connector: " o ", two_words_connector: " y ", last_word_connector: " o al menos "]]]
      iex> List.to_sentence(['uno', 'dos', 'tres'], [{:locale, es}])
      "uno o dos o al menos tres"

  """
  @to_sentence [
    valid_options: ~w(words_connector
                      two_words_connector
                      last_word_connector
                      locale)a,
    default_options: [
      words_connector: ", ",
      two_words_connector: " and ",
      last_word_connector: ", and "
    ]
  ]

  @spec to_sentence(t) :: t
  def to_sentence(words, options \\ [])
  def to_sentence([],     _), do: ""
  def to_sentence([word], _), do: "#{word}"
  def to_sentence(words, provided_options) do
    Crutches.Keyword.validate_keys!(provided_options, @to_sentence[:valid_options])

    options = merge_default_options(provided_options)
    start_of = words
      |> Crutches.List.shorten
      |> Enum.join(options[:words_connector])

    case length(words) do
      2 -> connector = options[:two_words_connector]
      _ -> connector = options[:last_word_connector]
    end

    "#{start_of}#{connector}#{List.last(words)}"
  end

  defp merge_default_options(options) do
    new_options = @to_sentence[:default_options] |> Keyword.merge(options)
    if new_options[:locale] do
      new_options |> Keyword.merge(options[:locale][:support][:array])
    else
      new_options
    end
  end

  @doc ~S"""
  Shorten a list by a given amount.

  When the list is shorter than the amount given, this function returns nil.

  ## Examples

      iex> List.shorten(["one", "two", "three"], 2)
      ["one"]

      iex> List.shorten([5, 6], 2)
      []

      iex> List.shorten([5, 6, 7, 8], 5)
      nil
  """
  @spec shorten(t, integer) :: t
  def shorten(list, amount \\ 1)
  def shorten(list, amount) when length(list) < amount, do: nil
  def shorten(list, amount) when length(list) == amount, do: []
  def shorten([head | tail], amount) when length(tail) == amount, do: [head]
  def shorten([head | tail], amount) when length(tail) > amount do
    [head | shorten(tail, amount)]
  end

  @doc ~S"""
  Returns a copy of the List from the beginning to the required index.

  ## Examples

      iex> List.to(["a", "b", "c"], 0)
      ["a"]

      iex> List.to(["a", "b", "c"], 1)
      ["a", "b"]

      iex> List.to(["a", "b", "c"], 20)
      ["a", "b", "c"]

      iex> List.to(["a", "b", "c"], -1)
      []
  """
  @spec to(t, i) :: t
  def to(collection, position) do
    if position >= 0, do: Enum.take(collection, position + 1), else: []
  end

  @doc ~S"""
  Return a List containing the original List splitted by an element or by a
  function.

  ## Examples

      iex> List.split(["a", "b", "c", "d", "c", "e"], "c")
      [["a", "b"], ["d"], ["e"]]

      iex> List.split(["c", "a", "b"], "c")
      [[], ["a", "b"]]

      iex> List.split([], 1)
      [[]]

      iex> List.split([1, 2, 3, 4, 5, 6, 7, 8], fn(x) -> rem(x, 2) == 0 end)
      [[1], [3], [5], [7], []]

      iex> List.split(1..15, &(rem(&1,3) == 0))
      [[1, 2], [4, 5], [7, 8], [10 , 11], [13, 14], []]
  """
  @spec split(t, any) :: t
  def split(collection, x) do
    {head, acc} = do_split(collection, x)
    Enum.reverse(acc, [Enum.reverse(head)])
  end

  defp do_split(collection, predicate) when is_function(predicate) do
    collection
    |> Stream.map(fn (elem) -> {predicate.(elem), elem} end)
    |> Enum.reduce {[], []}, fn
      {true,  _},    {head, acc} -> {[], [Enum.reverse(head) | acc]}
      {false, elem}, {head, acc} -> {[elem | head], acc}
    end
  end

  defp do_split(collection, x) do
    do_split(collection, fn (k) -> k == x end)
  end
end
