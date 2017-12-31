module Archer
  module Utils
    class Loader
      class << self
        def load_app
          FilesLoader.new(app_path).load
        end

        def load_config
          FilesLoader.new(config_path).load
        end

        private
        def app_path
          File.join Config.root_dir, 'app', '**/*.rb'
        end

        def config_path
          File.join Config.root_dir, 'config', '*.rb'
        end
      end
    end
  end
end
