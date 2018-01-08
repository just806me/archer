module Archer
  module Routes
    module RouteFinder
      extend self

      def find_for update
        route = ROUTES[update.type].detect { |route| route.match? update }

        route.for update if route
      end
    end
  end
end
