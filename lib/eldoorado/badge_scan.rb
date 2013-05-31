module Eldoorado
  class BadgeScan
    def self.badges_url
      "#{BASE_URL}/badge_scans.json"
    end

    def self.badge_url(id)
      "#{BASE_URL}/badge_scans/#{id}.json"
    end
    
    def self.find_all_for_entrant(id)
      all.find_all {|badge_scan| badge_scan.entrant_id == id}
    end

    def self.all
      response = Server.get_resource(badges_url)
      json = JSON.parse response

      json.each_with_object([]) do |data, badge_scans|
        badge_scan = assign_params_from_json(data)
        badge_scans << badge_scan
      end
    end

    def self.assign_params_from_json(data)
      badge_scan = Hashie::Mash.new

      badge_scan.entrant_id = data['entrant_id']
      badge_scan.scan_time  = data['scan_time']
      badge_scan.door_id    = data['door_id']

      badge_scan
    end
  end
end