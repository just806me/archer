module Archer
  module Utils
    class UpdateDecorator
      def initialize update
        @update = update
      end

      def decorate!
        @update.type = update_type

        @update.data = update_data
      end

      private
      def update_type
        @update_type ||= \
          case
          when @update.message&.text.present?
            :text_message
          when @update.inline_query.present?
            :inline_query
          when @update.callback_query.present?
            :callback_query
          end
      end

      def update_data
        @update_data ||= \
          case update_type
          when :text_message
            @update.message.text
          when :inline_query
            @update.inline_query.query
          when
            @update.callback_query.data
          end
      end
    end
  end
end
