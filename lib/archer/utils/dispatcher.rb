module Archer
  module Utils
    class Dispatcher
      def start
        loop do
          fetch_updates

          process_updates
        end
      end

      def fetch_updates
        request.params[:offset] = @offset

        response = JSON.parse request.send.body, object_class: OpenStruct

        @updates = response.ok ? response.result : []
      end

      private
      def request
        @request ||= Telegram::Request.new method: :get_updates
      end

      def process_updates
        return if @updates.blank?

        @updates.each do |update|
          UpdateDecorator.new(update).decorate!

          route = Routes::RouteFinder.new(update).find

          route.process update if route
        end

        @offset = @updates.max_by(&:update_id).update_id + 1
      end

      class << self
        delegate :start, to: :new
      end
    end
  end
end
