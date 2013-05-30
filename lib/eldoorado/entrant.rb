module Eldoorado
  class Entrant
    def self.base_url
      "http://localhost:3000"
    end

    def self.get_resource(url)
      RestClient.get url
    end

    def self.post_resource(url, params)
      RestClient.post url, entrant: params
    end

    def self.entrants_url
      url = "#{base_url}/entrants.json"
    end

    def self.entrant_url(id)
      "#{base_url}/entrants/#{id}.json"
    end

    def self.all
      response = get_resource(entrants_url)
      json = JSON.parse response

      json.each_with_object([]) do |data, entrants|
        entrant = assign_params_from_json(data)
        entrants << entrant
      end
    end

    def self.find(id)
      response = get_resource(entrant_url(id))
      json = JSON.parse response

      # How to account for 404 errors?
      assign_params_from_json(json)
    end

    def self.create(params)
      response = post_resource(entrants_url, params)
      json = JSON.parse response

      assign_params_from_json(json)
    end

    def self.assign_params_from_json(data)
      entrant = Hashie::Mash.new
      entrant.entrant_id  = data['id'].to_i
      entrant.first_name  = data['first_name']
      entrant.last_name   = data['last_name']
      entrant.guest       = data['guest']
      entrant.company_id  = data['company_id']
      entrant.access_type = data['access_type']
      entrant
    end
  end
end