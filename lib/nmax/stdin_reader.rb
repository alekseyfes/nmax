module Nmax
  class StdinReader
    attr_reader :str_length, :str_count

    def initialize(str_length:, str_count: nil)
      @str_length = str_length
      @str_count = str_count
    end

    def call
      # str = gets(@str_length)
      # arr = [str]
      # count = 1
      #
      # while str.present? && !limit_reached?(count)
      #   str = gets(@str_length)
      #   arr << str
      #   count += 1
      # end
      #
      # arr
    end

    private
    def limit_reached?(count)
      @str_count ? count == @str_count : false
    end
  end
end
