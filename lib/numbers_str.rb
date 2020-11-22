module NumbersStr
  extend self

  START_NUM_REGEXP = /^\d+/.freeze
  END_NUM_REGEXP = /\d+$/.freeze

  # @return [Boolean]
  def start_with_num?(str)
    str ||= ''
    str.match?(START_NUM_REGEXP)
  end

  # @return [Boolean]
  def end_with_num?(str)
    str ||= ''
    str.match?(END_NUM_REGEXP)
  end

  # @return [Boolean]
  def str_is_number?(str)
    str ||= ''
    str.match?(/^\d+$/)
  end

  # @return [Array]
  def numbers_from_str(str)
    str ||= ''
    str.scan(/\d+/).uniq.map(&:to_i)
  end
end
