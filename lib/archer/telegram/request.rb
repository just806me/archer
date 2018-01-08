module Archer
  module Telegram
    class Request
      attr_reader :params

      delegate :base_url, to: :class

      def initialize method, params = {}
        @method = method.to_s.camelize :lower

        @params = params
      end

      def send
        Net::HTTP.post_form url, params
      end

      private
      def url
        @url ||= URI(base_url + @method)
      end

      class << self
        def base_url
          @base_url ||= "https://api.telegram.org/bot#{ CONFIG.telegram.token }/"
        end
      end
    end
  end
end
