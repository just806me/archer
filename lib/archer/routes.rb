module Archer
  ROUTES = { text_message: [], inline_query: [], callback_query: [] }
end

require 'archer/routes/route'
require 'archer/routes/route_drawer'
require 'archer/routes/route_finder'
