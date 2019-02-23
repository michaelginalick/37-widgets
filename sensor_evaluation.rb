require 'bigdecimal'
require_relative 'classification'

class SensorEvaluation

  REFERENCE = "reference".freeze
  HUMIDITY = "humidity".freeze
  THERMOMETER = "thermometer".freeze
  

  attr_reader :log_file
  attr_accessor :reference_hash, :data_hash

  def initialize(log_file)
    @log_file = log_file.read
    @reference_hash = {}
    @data_hash = {}
  end

  def fetch_reference_hash
    log_file.split("\n").each do |row|
      line = row.split(" ")
      return reference_hash = { "degrees": line[1], "humidity": line.last} if line.include?(REFERENCE)
    end
  end


  def extract_data
    rows = log_file.split("\n")
    i = 0
    while i < rows.length
      row = rows[i].split(" ")
      
      if row[0].include?(THERMOMETER)
        set_to_array(row)
        j = i+1
        while next_item?(rows[j], THERMOMETER)
          break if next_widget?(rows[j], HUMIDITY)
          insert_row(row, data_hash, (temperature = rows[j].split(" ")))
          j = j + 1
        end
      elsif row[0].include?(HUMIDITY)
        set_to_array(row)
        p = i+1
        while next_item?(rows[p], HUMIDITY)
          insert_row(row, data_hash, (temperature = rows[p].split(" ")))
          p = p + 1
        end
      end

      i = i + 1
    end
    data_hash
  end

  def calculate_percision
    data = extract_data
    reference_point = fetch_reference_hash
    Classification.new(data, reference_point).determine_percision
  end


  private 

  def insert_row(row, data_hash, temperature)
    data_hash[row[1]] << BigDecimal.new(temperature.last)
  end

  def next_item?(row, widget_type)
    row && row.split(" ").first != widget_type
  end

  def set_to_array(row)
    data_hash[row[1]] = []
  end

  def next_widget?(row, widget_type)
    row.split(" ").first == HUMIDITY
  end

end
