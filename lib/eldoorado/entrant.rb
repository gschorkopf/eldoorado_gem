module Eldoorado
  class Entrant
    def self.entrants_url
      "#{BASE_URL}/entrants.json"
    end

    def self.entrant_url(id)
      "#{BASE_URL}/entrants/#{id}.json"
    end

    def self.all
      response = Server.get_resource(entrants_url)
      json = JSON.parse response

      assign_multiple_from_json(json)
    end

    def self.find(id)
      response = Server.get_resource(entrant_url(id))
      json = JSON.parse response

      assign_params_from_json(json)
    end

    def self.create(params)
      response = Server.post_resource(entrants_url, {entrant: params})
      json = JSON.parse response

      assign_params_from_json(json)
    end

    def self.assign_multiple_from_json(json)
      json.each_with_object([]) do |data, entrants|
        entrant = assign_params_from_json(data)
        entrants << entrant
      end
    end

    def self.assign_params_from_json(data)
      entrant = Hashie::Mash.new

      entrant.id          = data['id'].to_i
      entrant.first_name  = data['first_name']
      entrant.last_name   = data['last_name']
      entrant.guest       = data['guest']
      entrant.access_type = data['access_type']
      entrant.company     = data['company']
      entrant.badge_scans = data['badge_scans']

      entrant
    end
  end
end