module Archer
  module Utils
    module Loader
      extend self

      def load_app
        FilesLoader.load app_path
      end

      def load_config
        FilesLoader.load config_path
      end

      private
      def app_path
        File.join CONFIG.root_dir, 'app', '**/*.rb'
      end

      def config_path
        File.join CONFIG.root_dir, 'config', '*.rb'
      end
    end
  end
end
