require 'rest-client'
require 'json'
require 'hashie'
require 'eldoorado/entrant'
require 'eldoorado/badge_scan'
require 'eldoorado/company'
require 'eldoorado/door'


module Eldoorado
  BASE_URL = "http://eldoorado-api.herokuapp.com"

  class Server
    def self.get_resource(url)
      RestClient.get url
    end

    def self.post_resource(url, params = {})
      RestClient.post url, params
    end
  end
end