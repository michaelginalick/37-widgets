require_relative '../humidity_sensor'

describe HumiditySensor do

  context "given a target and array of numbers" do

    describe "#classify" do
      context "within 1% of reference value" do
        it "will return 'keep'" do
          humidity_sensor = HumiditySensor.new(45.0, [45.2, 45.3, 45.1])
          expect(humidity_sensor.classify). to eq("keep")
        end
      end
  
      context "outside of 1% of reference value" do
        it "will return 'discard' " do
          humidity_sensor = HumiditySensor.new(45.0, [44.4, 43.9, 44.9, 43.8, 42.1])
          expect(humidity_sensor.classify). to eq("discard")
        end
      end
    end
  end
end
