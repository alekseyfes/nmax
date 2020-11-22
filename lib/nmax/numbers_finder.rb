class NumbersInText
  include Numbers

  def call(strings)
    numbers = numbers_from_str(strings.first)

    strings[1..].each_with_index do |str, i|
      new_numbers = numbers_from_str(str)
      pre_str = strings[i]
      
      if number_on_line_break?(pre_str, str)
        concat_and_glue_arrs!(numbers, new_numbers)
      else
        numbers += new_numbers
      end
    end
    
    numbers
  end
end
