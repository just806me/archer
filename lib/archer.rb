require 'active_support/all'
require 'net/http'

require 'archer/telegram'
require 'archer/views'
require 'archer/controller'
require 'archer/matchers'
require 'archer/routes'

module Archer
  CONFIG = OpenStruct.new telegram: OpenStruct.new(parse_mode: :markdown, token: nil), root_dir: nil

  ROUTES = Hash.new { |hash, key| hash[key] = [] }

  extend self

  def configure
    yield Archer::CONFIG
  end

  def draw_routes
    yield Archer::Routes::RouteDrawer
  end
end
