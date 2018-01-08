module Archer
  module Routes
    module RouteDrawer
      extend self

      def route *params
        options = params.extract_options!

        route = Route.new params[0], options

        ROUTES[options[:type]] << route
      end
    end
  end
end
