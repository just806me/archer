require 'active_support/all'
require 'net/http'

require 'archer/config'
require 'archer/handlers'
require 'archer/telegram/request'
require 'archer/view_helper'
require 'archer/renderer'
require 'archer/handler'

module Archer
  class << self
    def configure
      yield Archer::Config
    end
  end
end
