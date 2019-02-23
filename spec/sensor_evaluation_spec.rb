require_relative '../sensor_evaluation'
require 'pry'

describe SensorEvaluation do
  
  describe "#fetch_reference_hash" do
    it "will return a hash" do
      file = File.open('./log.txt')
      sensory_evaluation = SensorEvaluation.new(file)
      expect(sensory_evaluation.fetch_reference_hash.class).to eq(Hash)
      file.close
    end

    it "will have the expected keys" do
      file = File.open('./log.txt')
      expected_keys = [:degrees, :humidity]
      sensory_evaluation = SensorEvaluation.new(file)
      expect(sensory_evaluation.fetch_reference_hash.keys).to match_array(expected_keys)
      file.close
    end
  end

  describe "#extract_data" do
    it "will parse the file and return a hash" do
      file = File.open('./log.txt')
      sensory_evaluation = SensorEvaluation.new(file)
      expect(sensory_evaluation.extract_data.class).to eq(Hash)
      file.close
    end


    it "will return a hash with the expected keys" do
      file = File.open('./log.txt')
      expected_keys = ["temp-1", "temp-2", "hum-1", "hum-2"]
      sensory_evaluation = SensorEvaluation.new(file)
      expect(sensory_evaluation.extract_data.keys).to eq(expected_keys)
      file.close
    end


    it "for each key the value will be an array of big decimals" do
      file = File.open('./log.txt')
      expected_keys = ["temp-1", "temp-2", "hum-1", "hum-2"]
      sensory_evaluation = SensorEvaluation.new(file)
      sensory_evaluation.extract_data.each do |key, value|
        expect(value.class).to eq(Array)
        value.each do |val|
          expect(val.class).to eq(BigDecimal)
        end
      end
      file.close
    end

    it "will parse the values correctly" do
      file = File.open('./log.txt')
      expected_keys = ["temp-1", "temp-2", "hum-1", "hum-2"]
      sensory_evaluation = SensorEvaluation.new(file)
      expect(sensory_evaluation.extract_data.first[1]).not_to include(69.5)
      file.close
    end

  end

  describe "#calculate_percision" do
    it "will return the expected output" do
      file = File.open('./log.txt')
      expected_output = {"hum-1"=>"keep", 
                         "hum-2"=>"discard", 
                         "temp-1"=>"precise", 
                         "temp-2"=>"ultra precise"
                        }
      sensory_evaluation = SensorEvaluation.new(file)
      expect(sensory_evaluation.calculate_percision).to eq(expected_output)
      file.close
    end
  end

end
