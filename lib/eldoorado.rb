require 'rest-client'
require 'json'
require 'hashie'
require './lib/eldoorado/entrant'

# IRB Testing:

## rails s -p 3000 in 'eldoorado' API
## enter irb
## require './lib/eldoorado_gem'

# all_entrants = EldooradoGem.entrants
# entrant = EldooradoGem.find_entrant(1)
##
# params = {first_name: "Geoff", last_name: "Schorkopf", company_id: 1, guest: false}
# entrant = EldooradoGem.create_entrant(params)