module Archer
  module Utils
    class ConfigLoader
      class << self
        def load
          Dir.glob(config_files) { |path| require path }
        end

        def config_files
          File.join Config.root_dir, 'config', '*.rb'
        end
      end
    end
  end
end
