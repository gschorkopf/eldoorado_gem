module Eldoorado
  class Company
    def self.company_url(id)
      "#{BASE_URL}/companies/#{id}.json"
    end

    def self.find(id)
      response = Server.get_resource(company_url(id))
      json = JSON.parse response

      assign_params_from_json(json)
    end

    def self.assign_params_from_json(data)
      company = Hashie::Mash.new

      company.id   = data['id'].to_i
      company.name = data['name']

      company
    end

  end
end