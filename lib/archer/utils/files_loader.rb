module Archer
  module Utils
    module FilesLoader
      extend self

      def load path
        Dir.glob(path) { |file| require file }
      end
    end
  end
end
