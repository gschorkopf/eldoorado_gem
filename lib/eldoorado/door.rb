module Eldoorado
  class Door
    def self.doors_url
      "#{BASE_URL}/doors.json"
    end

    def self.door_url(id)
      "#{BASE_URL}/doors/#{id}.json"
    end

    def self.find(id)
      response = Server.get_resource(door_url(id))
      handle_json response
    end

    def self.handle_json(response, options={})
      json = JSON.parse response
      assign_params_from_json(json, options)
    end

    def self.assign_params_from_json(data, options={})
      door = Hashie::Mash.new

      door.id        = data['id'].to_i
      door.location  = data['location']
      door.badge_scans = door_scans(data['location']) unless options[:badge_scans] == :none

      door
    end

    def self.door_scans(location)
      @door_scans ||= BadgeScan.all.find_all{|scan| scan.door == location}
    end

    def self.create(params)
      response = Server.post_resource(doors_url, {door: params})
      handle_json response, badge_scans: :none
    end
  end
end