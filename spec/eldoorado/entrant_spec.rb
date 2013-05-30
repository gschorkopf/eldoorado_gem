require 'spec_helper'

describe Eldoorado::Entrant do 
  let!(:subject){Eldoorado::Entrant}

  describe ".entrants_url" do
    xit "returns the get/post url for entrants" do
      stub(subject.base_url).and_return("http://www.eldoorado.com")
      url = subject.entrants_url
      expect(url).to eq "http://www.eldoorado.com/entrants.json"
    end
  end

  describe ".find" do
    it "returns a hash of found entrant" do
      VCR.use_cassette('found_entrant') do
        result = subject.find(1)
        expect(result.entrant_id).to eq 1
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
end