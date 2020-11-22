module Numbers
  START_NUM_REGEXP = /^\d+/.freeze
  END_NUM_REGEXP = /\d+$/.freeze

  # def concat_and_glue_arrs!(first, second)
  #   num_start = first.pop
  #   num_end = second.first
  #   first << concat_numbers(num_start, num_end)
  #   first += second[1..]
  # end

  # def concat_numbers(first, second)
  #   "#{first}#{second}".to_i
  # end

  def start_with_num?(str)
    str.match?(START_NUM_REGEXP)
  end

  def end_with_num?(str)
    str.match?(END_NUM_REGEXP)
  end

  def str_is_number?(str)
    str.match?(/^\d+$/)
  end

  def numbers_from_str(str)
    str.scan(/\d+/).map(&:to_i)
  end
end
