require_relative 'thermometer'
require_relative 'humidity_sensor'
require_relative './errors/unexpected_input'

class Classification

  TEMP = "temp".freeze
  HUM = "hum".freeze

  attr_reader :data, :reference_point
  attr_accessor :percision_hash

  def initialize(data, reference_point)
    @data = data
    @reference_point = reference_point
    @percision_hash = {}
  end

  def determine_percision
    data.keys.each do |key|
      if key.include?(TEMP)
        percision_hash[key] = Thermometer.new(reference_point[:degrees].to_f, data[key]).classify
      elsif key.include?(HUM)
        percision_hash[key] = HumiditySensor.new(reference_point[:humidity].to_f, data[key]).classify
      else
        raise UnexpectedInput, "Unable to classify product #{key}"
      end
    end
    percision_hash
  end

end
