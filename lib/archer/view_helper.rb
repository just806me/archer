module Archer
  module ViewHelper
    class << self
      def bold text
        case Config.telegram.parse_mode
        when :html     then "<b>#{ text }</b>"
        when :markdown then "*#{ text }*"
        end
      end

      def italic text
        case Config.telegram.parse_mode
        when :html     then "<i>#{ text }</i>"
        when :markdown then "_#{ text }_"
        end
      end

      def fixed text
        case Config.telegram.parse_mode
        when :html     then "<code>#{ text }</code>"
        when :markdown then "`#{ text }`"
        end
      end

      def block text
        case Config.telegram.parse_mode
        when :html     then "<pre>#{ text }</pre>"
        when :markdown then "```#{ text }```"
        end
      end

      def link name, url
        case Config.telegram.parse_mode
        when :html     then "<a href=\"#{ url }\">#{ name }</a>"
        when :markdown then "[#{ name }](#{ url })"
        end
      end

      def mention name, id
        case Config.telegram.parse_mode
        when :html     then "<a href=\"tg://user?id=#{ id }\">#{ name }</a>"
        when :markdown then "[#{ name }](tg://user?id=#{ id })"
        end
      end
    end
  end
end
