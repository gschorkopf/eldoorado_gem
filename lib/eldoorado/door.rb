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
      json = JSON.parse response

      assign_params_from_json(json)
    end

    def self.assign_params_from_json(data)
      door = Hashie::Mash.new

      door.id        = data['id'].to_i
      door.location  = data['location']

      door
    end

    def self.create(params)
      response = Server.post_resource(doors_url, {door: params})
      json = JSON.parse response

      assign_params_from_json(json)
    end
  end
end