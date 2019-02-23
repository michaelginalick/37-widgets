require_relative '../calculation'

describe Calculation do

  context "given a target and array of numbers" do

    describe "#mean" do
      it "will return the mean rounded to 2 decimal places" do
        calculated_mean = Calculation.new([45.2, 45.3, 45.1])
        expect(calculated_mean.mean). to eq(45.20)
      end
    end


    describe "#standard_deviation" do
      it "will return the standard deviation rounded to 2 decimal places" do
        calculated_standard_deviation = Calculation.new([44.4, 43.9, 44.9, 43.8, 42.1])
        expect(calculated_standard_deviation.standard_deviation). to eq(1.06)
      end
    end
  end

  context "given an empty array" do

    describe "#mean" do
      it "will return 0.00 for the mean" do
        calculated_mean = Calculation.new([])
        expect(calculated_mean.mean). to eq(0.00)
      end
    end


    describe "#standard_deviation" do
      it "will return 0.00 for the standard deviation" do
        calculated_standard_deviation = Calculation.new([])
        expect(calculated_standard_deviation.standard_deviation). to eq(0.00)
      end
    end

  end
end
