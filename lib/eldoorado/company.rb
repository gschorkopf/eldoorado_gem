module Eldoorado
  class Company
    def self.companies_url
      "#{BASE_URL}/companies.json"
    end

    def self.company_url(id)
      "#{BASE_URL}/companies/#{id}.json"
    end

    def self.all
      response = Server.get_resource(companies_url)
      json = JSON.parse response

      assign_multiple_from_json(json)
    end

    def self.find(id)
      response = Server.get_resource(company_url(id))
      handle_json response
    end

    def self.find_by_name(name)
      response = Server.get_resource(company_url(name.capitalize))
      handle_json response
    end

    def self.create(params)
      response = Server.post_resource(companies_url, {company: params})
      handle_json response
    end

    def self.handle_json(response)
      json = JSON.parse response
      assign_params_from_json(json)
    end

    def self.assign_multiple_from_json(json)
      json.each_with_object([]) do |data, companies|
        company = assign_params_from_json(data)
        companies << company
      end
    end

    def self.assign_params_from_json(data)
      company = Hashie::Mash.new

      company.id   = data['id'].to_i
      company.name = data['name']

      company
    end

  end
end