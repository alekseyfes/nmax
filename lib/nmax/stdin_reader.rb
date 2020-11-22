class StdinReader
  attr_reader :io, :str_length, :str_count

  def initialize(io:, str_length:, str_count: nil)
    @io = io
    @str_length = str_length
    @str_count = str_count
  end

  def call
    arr = []
    count = 0

    loop do
      str = io.gets(@str_length)
      break if str.nil?

      str.chomp!
      next if str.empty?

      arr << str
      count += 1
      break if limit_exceeded?(count)
    end

    arr
  end

  private

  def limit_exceeded?(count)
    @str_count ? count == @str_count : false
  end
end
