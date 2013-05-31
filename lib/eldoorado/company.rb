module Eldoorado
  class Company

    def self.assign_params_from_json(data)
      company = Hashie::Mash.new

      company.id   = data['id'].to_i
      company.name = data['name']

      company
    end

  end
end