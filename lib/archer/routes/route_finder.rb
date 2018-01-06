module Archer
  module Routes
    class RouteFinder
      def initialize update
        @update = update
      end

      def find
        ROUTES[@update.type].detect { |route| route.match? @update }
      end
    end
  end
end
