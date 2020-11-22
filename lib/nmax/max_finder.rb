class MaxFinder
  attr_reader :count

  def initialize(count)
    @count = count.to_i
  end

  def call(numbers, max)
    (numbers | max).max(@count)
  end
end
