class HumiditySensor

  KEEP = "keep".freeze
  DISCARD = "discard".freeze
  RANGE_BOUND = 0.01

  attr_reader :humidity, :digits
  
  def initialize(humidity, digits)
    @humidity = humidity
    @digits = digits
  end


  def classify
    returned_value = KEEP
    digits.each do |digit|
      return returned_value = DISCARD unless within_range?(digit)
    end
    returned_value
  end

  private

  def within_range?(digit)
    (-RANGE_BOUND...RANGE_BOUND+RANGE_BOUND).cover?((digit.to_f -  humidity.to_f)/humidity.to_f)
  end

end
