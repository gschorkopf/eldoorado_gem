require 'spec_helper'

describe Eldoorado::Company do 
  let!(:subject){Eldoorado::Company}

  describe ".find" do
    it "returns a hash of found company by id" do
      VCR.use_cassette('found_company') do
        result = subject.find(1)
        expect(result.id).to eq 1
        expect(result.name).to eq "Roximity"
      end
    end
  end

  describe '.find_by_name'

  describe '.all' do
    it "returns all found companies" do
      VCR.use_cassette('all_companies') do
        results = subject.all
        (results.count).should be > 1
        expect(results.first.name).to eq "Roximity"
      end
    end
  end

  describe '.create' do
    it "returns the created company" do
      VCR.use_cassette('create_company') do
        params = {name: "Jumpstart Lab"}
        result = subject.create(params)
        expect(result.name).to eq "Jumpstart Lab"
      end
    end
  end

  describe '.badge_scans'

end