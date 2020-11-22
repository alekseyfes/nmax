require_relative "numbers_str"
require_relative "number_on_line_break"
require_relative "nmax/stdin_reader"
require_relative "nmax/numbers_finder"
require_relative "nmax/max_finder"
require_relative "nmax/version"

module Nmax
  include NumbersStr
  include NumberOnLineBreak
  extend self

  class Error < StandardError; end

  def find(n, io: $stdin, str_length: 1000, str_count: 100)
    max = []
    max_finder = MaxFinder.new(n)
    numbers_finder = NumbersFinder.new
    reader = StdinReader.new(io: io, str_length: str_length, str_count: str_count)


    strings = reader.call

    loop do
      next_strings = reader.call

      while !next_strings.empty? && end_with_num?(strings.last) && start_with_num?(next_strings.first)
        strings += next_strings
        next_strings = reader.call
      end

      numbers = numbers_finder.call(strings)
      max = max_finder.call(numbers, max)

      break if next_strings.empty?
      strings = next_strings
    end

    max
  end
end
