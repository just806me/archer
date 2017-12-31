module Archer
  module Utils
    class FilesLoader
      attr_reader :files_path

      def initialize files_path
        @files_path = files_path
      end

      def load
        Dir.glob(files_path) { |path| require path }
      end
    end
  end
end
