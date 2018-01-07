module Archer
  module Routes
    class RouteFinder
      class << self
        def find_for update
          ROUTES[update.type].detect { |route| route.match? update }
        end

        def find_and_process update
          find_for(update)&.process(update)
        end
      end
    end
  end
end
