require_relative '../thermometer'
describe Thermometer do

  context "given a target and array of numbers" do
    describe "#classify" do
      context "mean is in 0.5 of degrees and standard deviation > 5" do
        it "will return 'precise'" do
          thermometer = Thermometer.new(70.0, [72.4, 76.0, 79.1,
                                                  75.6, 71.2, 71.4, 
                                                  69.2, 65.2, 62.8, 
                                                  61.4, 64.0, 67.5, 
                                                  69.4])
          expect(thermometer.classify). to eq(Thermometer::PRECISE)
        end
      end

      context "mean is in 0.5 of degrees and standard deviation is < 3" do
        it "will return 'ultra precise' " do
          thermometer = Thermometer.new(70.0, [69.5, 70.1, 71.3, 71.5, 69.8])
          expect(thermometer.classify). to eq(Thermometer::ULTRA_PRECISE)
        end
      end

      context "mean is in 0.5 of degrees and standard deviation is > 3 and < 5" do
        it "will return 'very precise' " do
          thermometer = Thermometer.new(70.0, [77.5, 72.1, 71.3, 
                                              70.5, 69.8, 70.5, 
                                              70.4, 69.5, 70.0, 63.2])
          expect(thermometer.classify). to eq(Thermometer::VERY_PRECISE)
        end
      end
    end
  end
end
