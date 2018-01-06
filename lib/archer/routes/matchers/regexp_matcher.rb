module Archer
  module Routes
    module Matchers
      class RegexpMatcher
        def initialize regex, type
          @regex = regex

          @type = type
        end

        def match? update
          return false unless @type == update.type

          @regex.match? update.data
        end
      end
    end
  end
end
