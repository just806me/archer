module Archer
  module Matchers
    class RegexpMatcher
      def initialize regexp, type
        @regexp = regexp

        @type = type
      end

      def match? update
        return false unless @type == update.type

        @regexp.match? update.data
      end
    end
  end
end
