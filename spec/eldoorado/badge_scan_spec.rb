require 'spec_helper'

describe Eldoorado::BadgeScan do 
  describe '.all' do
    it "returns all found badge scans" do
      VCR.use_cassette('all_scans') do
        results = described_class.all
        (results.count).should be > 1
        expect(results.first.door).to eq "Atrium Door (In)"
        expect(results.first.first_name).to eq "Paul"
      end
    end
  end

  describe '.create' do
    it "creates a new badge scan" do
      VCR.use_cassette('create_scan') do
        params = {
          entrant_id: Eldoorado::Entrant.find_by_name("Paul", "Finkel").id,
          scan_time: "2013-05-29  04:40:29",
          door_id: 1
        }
        result = described_class.create(params)
        expect(result.door).to eq "Atrium Door (In)"
        expect(result.first_name).to eq "Paul"
      end
    end
  end
end