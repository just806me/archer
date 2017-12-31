require 'active_support/all'
require 'net/http'

require 'archer/telegram/request'
require 'archer/config'
require 'archer/view_helper'
require 'archer/handler'

require 'archer/handler_searcher'
require 'archer/dispatcher'

module Archer
  HANDLERS = []

  class << self
    def configure
      yield Archer::Config
    end

    def load_files
      load_config

      load_handlers
    end

    def load_config
      path = File.join Config.root_dir, 'config', '*.rb'

      Dir.glob(path) { |file| require file }
    end

    def load_handlers
      path = File.join Config.root_dir, 'app', 'handlers', '*.rb'

      Dir.glob path do |file|
        require file

        HANDLERS << File.basename(file, '.rb').classify.constantize
      end
    end
  end
end
