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

      json.each_with_object([]) do |data, entrants|
        entrant = assign_params_from_json(data)
        entrants << entrant
      end
    end

    def self.find(id)
      response = Server.get_resource(entrant_url(id))
      json = JSON.parse response

      assign_params_from_json(json)
    end

    def self.create(params)
      response = Server.post_resource(entrants_url, params)
      json = JSON.parse response

      assign_params_from_json(json)
    end

    def self.assign_params_from_json(data)
      entrant = Hashie::Mash.new
      entrant.id          = data['id'].to_i
      entrant.first_name  = data['first_name']
      entrant.last_name   = data['last_name']
      entrant.guest       = data['guest']
      entrant.access_type = data['access_type']
      entrant.company     = Company.find(data['company_id']).name
      entrant.badge_scans = BadgeScan.find_all_for_entrant(data['id'].to_i)

      entrant
    end
  end
end