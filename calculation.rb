class Calculation
  attr_reader :digits

  def initialize(digits)
    @digits = digits
  end

  def standard_deviation
    Math.sqrt(sample_variance).round(2)
  end

  def mean
    return 0.00 if digits.empty?
    (sum/digits.length.to_f).round(2)
  end


  private

  def sum
    digits.inject(0) {|accum, i| accum + i }
  end

  def sample_variance
    mean_of_digits = mean
    sum = digits.inject(0) {|accum, i| accum +(i-mean_of_digits)**2 }
    sum/(digits.length - 1).to_f.round(2)
  end
end
