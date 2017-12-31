module Archer
  module Utils
    class AppLoader
      class << self
        def load
          loader.load
        end

        def loader
          FilesLoader.new path
        end

        def path
          File.join Config.root_dir, 'app', '**/*.rb'
        end
      end
    end
  end
end
