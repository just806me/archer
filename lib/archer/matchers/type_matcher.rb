module Archer
  module Matchers
    class TypeMatcher
      def initialize type
        @type = type
      end

      def match? update
        @type == update.type
      end
    end
  end
end
