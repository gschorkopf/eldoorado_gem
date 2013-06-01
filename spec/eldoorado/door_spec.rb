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

  describe '.find_by_location'

  describe ".create" do
    it "returns the created entrant" do
      VCR.use_cassette('create_door') do
        params = {location: "Rooftop Escape"}
        result = described_class.create(params)
        expect(result.location).to eq "Rooftop Escape"
      end
    end
  end

  describe ".badge_scans"

end