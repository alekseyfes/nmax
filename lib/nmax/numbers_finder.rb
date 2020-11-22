class NumbersFinder
  include NumbersStr
  include NumberOnLineBreak

  # @return [Array<Integer>]
  def call(strings)
    strings = without_number_on_br(strings)
    strings.flat_map { |str| numbers_from_str(str) }.uniq
  end
end
