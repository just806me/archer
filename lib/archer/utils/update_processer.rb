module Archer
  module Utils
    class UpdateProcesser
      delegate :controller, :view, :action, to: :route

      def initialize update
        @update = update
      end

      def process
        decorate_update!

        return if route.blank?

        controller.public_send action if controller.respond_to? action

        @content = view.render_for controller.binding

        request.send
      end

      private
      def decorate_update!
        UpdateDecorator.decorate! @update
      end

      def route
        @route ||= Routes::RouteFinder.find_for @update
      end

      def request
        case @update.type
        when :text_message
          Telegram::Request.new :send_message,
            chat_id: @update.message.chat.id, parse_mode: CONFIG.telegram.parse_mode, text: @content
        end
      end

      class << self
        def process update
          new(update).process
        end
      end
    end
  end
end
