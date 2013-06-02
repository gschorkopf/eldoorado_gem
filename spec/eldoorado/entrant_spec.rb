require 'spec_helper'

describe Eldoorado::Entrant do 
  describe ".find" do
    it "returns a hash of found entrant" do
      VCR.use_cassette('found_entrant') do
        result = described_class.find(1)
        expect(result.id).to eq 1
        expect(result.first_name).to eq "Paul"
      end
    end
  end

  describe ".find_by_name" do
    it "returns a hash of found entrant, case insensitive" do
      VCR.use_cassette('found_entrant_by_name') do
        result = described_class.find_by_name("paul", "finkel")
        expect(result.id).to eq 1
        expect(result.first_name).to eq "Paul"
      end
    end
  end

  describe ".all" do
    it "returns all found entrants" do
      VCR.use_cassette('all_entrant') do
        results = described_class.all
        (results.count).should be > 1
        expect(results.first.first_name).to eq "Paul"
      end
    end
  end

  describe ".create" do
    it "returns the created entrant" do
      VCR.use_cassette('create_entrant') do
        params = {first_name: "Geoff",
                  last_name: "Schorkopf",
                  company_id: 1,
                  guest: false}
        result = described_class.create(params)
        expect(result.first_name).to eq "Geoff"
        expect(result.last_name).to eq "Schorkopf"
      end
    end
  end

  describe ".company" do
    it "returns the company associated with that entrant" do
      VCR.use_cassette('return_entrant_company') do
        result = described_class.find(1)
        expect(result.id).to eq 1
        expect(result.company).to eq "Roximity"
      end
    end
  end

  describe ".badge_scans" do
    it "returns the badge scans associated with that entrant" do
      VCR.use_cassette('return_entrant_scans') do
        result = described_class.find(1)
        expect(result.id).to eq 1
        (result.badge_scans.count).should be >= 1
        expect(result.badge_scans.first.first_name).to eq result.first_name
      end
    end
  end
end