module Archer
  class Handler
    attr_reader :update

    delegate :renderer, to: :class

    delegate :render, to: :renderer

    def initialize update
      @update = update
    end

    def respond
      answer.send
    end

    private
    def answer
      @answer ||= \
        case
        when update.message.present?
          Telegram::Request.new method: :send_message, params: {
            chat_id: update.message.chat.id, text: render,
            parse_mode: Config.telegram.parse_mode
          }
        end
    end

    class << self
      def command name
        define_singleton_method :can_handle? do |update|
          return false if update.message.blank?

          /\A\/#{ name }/.match? update.message.text
        end
      end

      def renderer
        @renderer ||= Renderer.new self
      end
    end
  end
end
