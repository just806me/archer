module Archer
  class Handler
    attr_reader :update

    def initialize update
      @update = update
    end

    def respond
      answer.send
    end

    def render
      self.class.renderer.result binding
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

    def binding
      ViewHelper.instance_eval { binding }
    end

    class << self
      def command name
        define_singleton_method :can_handle? do |update|
          return false if update.message.blank?

          /\A\/#{ name }/.match? update.message.text
        end
      end

      def renderer
        @renderer ||= ERB.new template
      end

      private
      def template
        @view ||= File.read view_path
      end

      def view_path
        @view_path ||= File.join Config.root_dir, 'app', 'views', view_name
      end

      def view_name
        @view_name ||= "#{ name.remove(/Handler\z/).downcase }.txt.erb"
      end
    end
  end
end
