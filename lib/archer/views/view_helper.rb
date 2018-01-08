module Archer
  module Views
    module ViewHelper
      extend self

      def get_binding
        binding
      end

      def bold text
        case CONFIG.telegram.parse_mode
        when :html     then "<b>#{ text }</b>"
        when :markdown then "*#{ text }*"
        end
      end

      def italic text
        case CONFIG.telegram.parse_mode
        when :html     then "<i>#{ text }</i>"
        when :markdown then "_#{ text }_"
        end
      end

      def fixed text
        case CONFIG.telegram.parse_mode
        when :html     then "<code>#{ text }</code>"
        when :markdown then "`#{ text }`"
        end
      end

      def block text
        case CONFIG.telegram.parse_mode
        when :html     then "<pre>#{ text }</pre>"
        when :markdown then "```#{ text }```"
        end
      end

      def link name, url
        case CONFIG.telegram.parse_mode
        when :html     then "<a href=\"#{ url }\">#{ name }</a>"
        when :markdown then "[#{ name }](#{ url })"
        end
      end

      def mention name, id
        case CONFIG.telegram.parse_mode
        when :html     then "<a href=\"tg://user?id=#{ id }\">#{ name }</a>"
        when :markdown then "[#{ name }](tg://user?id=#{ id })"
        end
      end
    end
  end
end
