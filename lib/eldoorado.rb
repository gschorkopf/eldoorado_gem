require 'rest-client'
require 'json'
require 'hashie'

module Eldoorado
  class Entrant
    BASE_URL = "http://localhost:3000"

    def self.get_resource(url)
      RestClient.get url
    end

    def self.post_resource(url, params)
      RestClient.post url, entrant: params
    end

    def self.entrants_url
      url = "#{BASE_URL}/entrants.json"
    end

    def self.entrant_url(id)
      "#{BASE_URL}/entrants/#{id}.json"
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

# IRB Testing:

## rails s -p 3000 in 'eldoorado' API
## enter irb
## require './lib/eldoorado_gem'

# all_entrants = EldooradoGem.entrants
# entrant = EldooradoGem.find_entrant(1)
##
# params = {first_name: "Geoff", last_name: "Schorkopf", company_id: 1, guest: false}
# entrant = EldooradoGem.create_entrant(params)