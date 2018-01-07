module Archer
  module Utils
    class FilesLoader
      class << self
        def load path
          Dir.glob(path) { |file| require file }
        end
      end
    end
  end
end
