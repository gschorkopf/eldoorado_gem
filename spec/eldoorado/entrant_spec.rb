require 'spec_helper'

describe Eldoorado::Entrant do 
  let!(:subject){Eldoorado::Entrant}

  describe ".find" do
    it "returns a hash of found entrant" do
      VCR.use_cassette('found_entrant') do
        result = subject.find(1)
        expect(result.id).to eq 1
        expect(result.first_name).to eq "Paul"
      end
    end
  end

  describe ".all" do
    it "returns all found entrants" do
      VCR.use_cassette('all_entrant') do
        results = subject.all
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
        result = subject.create(params)
        expect(result.first_name).to eq "Geoff"
        expect(result.last_name).to eq "Schorkopf"
      end
    end
  end

  describe ".company" do
    it "returns the company associated with that entrant" do
      VCR.use_cassette('return_entrant_company') do
        result = subject.find(1)
        expect(result.id).to eq 1
        expect(result.company).to eq "Roximity"
      end
    end
  end

  describe ".badge_scans" do
    xit "returns the badge scans associated with that entrant" do
      VCR.use_cassette('return_entrant_scans') do
        result = subject.find(1)
        expect(result.id).to eq 1
        (result.badge_scans.count).should be > 1
        expect(result.badge_scans.first.entrant_id).to eq result.entrant_id 
      end
    end
  end
end