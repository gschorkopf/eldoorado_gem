module Eldoorado
  class BadgeScan
    

    def self.assign_multiple_from_json(json = [])
      json.each_with_object([]) do |data, badge_scans|
        badge_scan = assign_params_from_json(data)
        badge_scans << badge_scan
      end
    end

    def self.assign_params_from_json(data)
      badge_scan = Hashie::Mash.new

      badge_scan.scan_time  = data['scan_time']
      badge_scan.door       = data['door']['location']

      badge_scan
    end
  end
end