module Eldoorado
  class BadgeScan
    def self.badges_url
      "#{BASE_URL}/badge_scans.json"
    end

    def self.all
      response = Server.get_resource(badges_url)
      json = JSON.parse response

      assign_multiple_from_json(json)
    end

    def self.assign_multiple_from_json(json)
      json.each_with_object([]) do |data, badge_scans|
        badge_scan = assign_params_from_json(data)
        badge_scans << badge_scan
      end
    end

    def self.assign_params_from_json(data)
      badge_scan = Hashie::Mash.new

      badge_scan.entrant_first_name = data['entrant_first_name']
      badge_scan.entrant_last_name  = data['entrant_last_name']
      badge_scan.scan_time          = data['scan_time']
      badge_scan.door               = data['door']

      badge_scan
    end
  end
end