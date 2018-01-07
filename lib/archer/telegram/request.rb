module Archer
  module Telegram
    class Request
      attr_reader :params

      def initialize params
        @method = params[:method].to_s.camelize :lower

        @params = params[:params] || {}
      end

      def send
        Net::HTTP.post_form url, params
      end

      private
      def url
        @url ||= URI(self.class.url + @method)
      end

      class << self
        def url
          @url ||= "https://api.telegram.org/bot#{ CONFIG.telegram.token }/"
        end
      end
    end
  end
end
