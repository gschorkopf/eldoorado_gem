require 'spec_helper'

describe Eldoorado::BadgeScan do 
  let!(:subject){Eldoorado::BadgeScan}

  describe '.find_by_door'

  describe '.all' do
    it "returns all found badge scans" do
      VCR.use_cassette('all_scans') do
        results = subject.all
        (results.count).should be > 1
        expect(results.first.door).to eq "Atrium Door (In)"
        expect(results.first.entrant_first_name).to eq "Paul"
      end
    end
  end

  describe '.create'
  # What inputs should this take?
end