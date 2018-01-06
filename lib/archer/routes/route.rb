module Archer
  module Routes
    class Route
      delegate :match?, to: :matcher

      def initialize param, options
        @type = options[:type]

        @controller_name, @action = options[:to].split '#'

        @param = param
      end

      def process update
        controller_klass.new(update, @action).process
      end

      private
      def matcher
        @matcher ||= \
          case @param
          when Regexp
            Matchers::RegexpMatcher.new @param, @type
          when Symbol
            Matchers::CommandMatcher.new @param, @type
          when Class
            @param.new
          else
            Matchers::TypeMatcher.new @type
          end
      end

      def controller_klass
        @controller_klass ||= "#{ @controller_name.camelize }Controller".constantize
      end
    end
  end
end
