require 'spec_helper'

describe Eldoorado::BadgeScan do 
  describe '.find_by_door'

  describe '.all' do
    it "returns all found badge scans" do
      VCR.use_cassette('all_scans') do
        results = described_class.all
        (results.count).should be > 1
        expect(results.first.door).to eq "Atrium Door (In)"
        expect(results.first.entrant_id).to eq 1
      end
    end
  end

  describe '.create'
  # What inputs should this take?
end