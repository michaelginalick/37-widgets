require_relative 'calculation'

class Thermometer

  ULTRA_PRECISE = "ultra precise".freeze
  VERY_PRECISE = "very precise".freeze
  PRECISE = "precise".freeze
  LOWER_BOUND = 3
  UPPER_BOUND = 5
  RANGE_BOUND = 0.5

  attr_reader :degrees, :digits, :standard_deviation, :mean

  def initialize(degrees, digits)
    @degrees = degrees
    @digits = digits
    calculation = Calculation.new(digits)
    @standard_deviation = calculation.standard_deviation
    @mean = calculation.mean
  end



  def classify
    if ultra_presise?
      ULTRA_PRECISE
    elsif precise?
      VERY_PRECISE
    else
      PRECISE
    end
  end

  private

  def within_range?
    (degrees - RANGE_BOUND...degrees + RANGE_BOUND).cover?(mean)
  end

  def precise?
    (standard_deviation > LOWER_BOUND) && (standard_deviation < UPPER_BOUND) && within_range?
  end

  def ultra_presise?
    (standard_deviation < LOWER_BOUND) && within_range?
  end
end
