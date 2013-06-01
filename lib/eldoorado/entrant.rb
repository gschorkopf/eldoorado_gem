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
      handle_json response
    end

    def self.find_by_name(first_name, last_name)
      params = "#{first_name.capitalize},#{last_name.capitalize}"
      response = Server.get_resource(entrant_url(params))
      handle_json response
    end

    def self.create(params)
      response = Server.post_resource(entrants_url, {entrant: params})
      handle_json response
    end

    def self.handle_json(response)
      json = JSON.parse response
      assign_params_from_json(json)
    end

    def self.assign_multiple_from_json(json, options={})
      json.each_with_object([]) do |data, entrants|
        entrant = assign_params_from_json(data, options)
        entrants << entrant
      end
    end

    def self.assign_params_from_json(data, options={})
      entrant = Hashie::Mash.new

      entrant.id          = data['id'].to_i
      entrant.first_name  = data['first_name']
      entrant.last_name   = data['last_name']
      entrant.guest       = data['guest']
      entrant.access_type = data['access_type']
      entrant.company     = data['company']
      entrant.badge_scans = data['badge_scans'] unless options[:badge_scans] == :none

      entrant
    end
  end
end