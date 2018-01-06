module Archer
  module Utils
    class FilesLoader
      def initialize path
        @path = path
      end

      def load
        Dir.glob(@path) { |file| require file }
      end
    end
  end
end
