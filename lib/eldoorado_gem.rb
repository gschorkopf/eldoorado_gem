require 'nokogiri'
require 'open-uri'
require 'json'
require 'hashie'

class EldooradoGem
  BASE_URL = "http://localhost:3000"

  def self.get_resource(url)
    Nokogiri::HTML(open(url))
  end

  def self.entrants_url
    url = "#{BASE_URL}/entrants.json"
  end

  def self.entrant_list
    json = JSON.parse(get_resource(entrants_url))

    json.each_with_object([]) do |data, entrants|
      entrant = assign_entrant_params(data)
      entrants << entrant
    end
  end

  def self.assign_entrant_params(data)
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

# IRB Testing:

## rails s -p 3000 in 'eldoorado' API
## enter irb
## require './lib/eldoorado_gem'
