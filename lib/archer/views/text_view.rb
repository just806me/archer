module Archer
  module Views
    class TextView
      def initialize path
        @path = path
      end

      def request_for update
        case update.type
        when :text_message
          Telegram::Request.new method: :send_message, params: {
            chat_id: update.message.chat.id, text: content,
            parse_mode: CONFIG.telegram.parse_mode
          }
        end
      end

      private
      def content
        @content ||= File.read @path
      end
    end
  end
end
