require 'active_support/all'
require 'net/http'

require 'archer/config'
require 'archer/telegram'
require 'archer/views'
require 'archer/controller'
require 'archer/matchers'
require 'archer/routes'

module Archer
  class << self
    def configure
      yield Archer::CONFIG
    end

    def draw_routes
      yield Archer::Routes::RouteDrawer
    end
  end
end
