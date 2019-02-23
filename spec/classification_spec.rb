require_relative '../classification'

describe Classification do
  data_hash = {"temp-1"=>[0.724e2, 0.76e2, 0.791e2, 0.756e2, 0.712e2, 0.714e2, 0.692e2, 0.652e2, 0.628e2, 0.614e2, 0.64e2, 0.675e2, 0.694e2],
    "temp-2"=>[0.695e2, 0.701e2, 0.713e2, 0.715e2, 0.698e2],
    "hum-1"=>[0.452e2, 0.453e2, 0.451e2],
    "hum-2"=>[0.444e2, 0.439e2, 0.449e2, 0.438e2, 0.421e2]}
  reference_hash = {:degrees=>"70.0", :humidity=>"45.0"}
  
  describe "#determine_percision" do

    context "given a hash and reference point hash" do
      it "will return a hash" do
        classification = Classification.new(data_hash, reference_hash)
        expect(classification.determine_percision.class).to eq(Hash)
      end

      it "parse the established keys" do
        hash_keys = [Classification::TEMP, Classification::HUM]
        classification = Classification.new(data_hash, reference_hash)
        classification.determine_percision.keys.each do |key|
          expect(key).to match(/#{hash_keys[0]}/).or match(/#{hash_keys[1]}/)
        end
      end

      context "for each key value pair" do
        it "will return the expected value for a given key" do
          expected_values = [Thermometer::ULTRA_PRECISE, Thermometer::VERY_PRECISE, 
                             Thermometer::PRECISE, HumiditySensor::KEEP, 
                             HumiditySensor::DISCARD
                            ]
          classification = Classification.new(data_hash, reference_hash)
          classification.determine_percision.each do |key, value|
            expect(expected_values).to include(value)
          end
        end
      end
    end

    context "hash with a key that is not established" do
      invalid_data_hash = {"bad-input" => [0.0, 0.0]}
      it "will raise exception" do
        classification = Classification.new(invalid_data_hash, reference_hash)
        expect { classification.determine_percision }.to raise_error(UnexpectedInput)
      end
    end
  end

end
