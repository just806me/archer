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
        response = JSON.parse request.send.body, object_class: OpenStruct

        @updates = response.ok ? response.result : []
      end

      private
      def request
        @request ||= Telegram::Request.new :get_updates
      end

      def process_updates
        return request.params[:offset] = nil if @updates.blank?

        @updates.each { |update| UpdateProcesser.process update }

        request.params[:offset] = @updates.max_by(&:update_id).update_id + 1
      end

      class << self
        delegate :start, to: :new
      end
    end
  end
end
