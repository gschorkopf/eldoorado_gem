require 'spec_helper'

describe Eldoorado::Door do 
  describe ".find" do
    it "returns a hash of found door" do
      VCR.use_cassette('found_door') do
        result = described_class.find(1)
        expect(result.id).to eq 1
        expect(result.location).to eq "Atrium Door (In)"
      end
    end
  end

  describe ".create" do
    it "returns the created entrant" do
      VCR.use_cassette('create_door') do
        params = {location: "Rooftop Escape"}
        result = described_class.create(params)
        expect(result.location).to eq "Rooftop Escape"
      end
    end
  end

  describe ".badge_scans" do
    it "returns the badge scans for found door" do
      VCR.use_cassette('badge_scans_door') do
        result = described_class.find(1)
        (result.badge_scans.count).should be > 1
        expect(result.badge_scans.first.door).to eq "Atrium Door (In)"
      end
    end
  end
end