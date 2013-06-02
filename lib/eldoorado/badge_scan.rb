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

    def self.create(params)
      response = Server.post_resource(badges_url, {badge_scan: params})
      json = JSON.parse response

      assign_params_from_json(json)
    end

    def self.assign_multiple_from_json(json)
      json.each_with_object([]) do |data, badge_scans|
        badge_scan = assign_params_from_json(data)
        badge_scans << badge_scan
      end
    end

    def self.assign_params_from_json(data)
      badge_scan = Hashie::Mash.new

      badge_scan.last_name    = data['last_name']
      badge_scan.first_name   = data['first_name'] 
      badge_scan.guest        = data['guest']
      badge_scan.company      = data['company']
      badge_scan.scan_time    = data['scan_time']
      badge_scan.door         = data['door']

      badge_scan
    end
  end
end