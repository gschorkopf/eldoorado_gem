require 'rest-client'
require 'json'
require 'hashie'
require 'eldoorado/entrant'
require 'eldoorado/badge_scan'
require 'eldoorado/company'
require 'eldoorado/door'


module Eldoorado
  BASE_URL = "http://localhost:3000"

  class Server
    def self.get_resource(url)
      RestClient.get url
    end

    def self.post_resource(url, params)
      RestClient.post url, entrant: params
    end
  end
end