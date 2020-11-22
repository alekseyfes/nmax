module NumberOnLineBreak
  include NumbersStr
  extend self
  
  # @return [Boolean]
  def number_on_line_break?(first, second)
    end_with_num?(first) && start_with_num?(second)
  end

  # @return [Array<String>]
  def without_number_on_br(strings)
    strings = [] if strings.nil?
    
    result = [strings.first].compact

    (strings[1..] || []).each do |str|
      last_str = result.last
      unless number_on_line_break?(last_str, str)
        result << str
        next
      end
      
      if str_is_number?(str)
        result[-1] = last_str + str
      else
        shift_br_from_number!(last_str, str)
        result[-1] = last_str
        result << str
      end
    end
    
    result.compact
  end

  def shift_br_from_number!(first, second)
    return unless number_on_line_break?(first, second)

    num_start = first.scan(END_NUM_REGEXP).first.to_s
    num_end = second.scan(START_NUM_REGEXP).first.to_s
    num = num_start + num_end
    first.sub!(END_NUM_REGEXP, num)
    second.sub!(START_NUM_REGEXP, '')
  end
end
