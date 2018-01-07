module Archer
  module Routes
    class Route
      delegate :match?, to: :matcher

      def initialize param, options
        @type = options[:type]

        @controller_path, @action = options[:to].split '#'

        @action = @action.to_sym

        @param = param
      end

      def process update
        controller_klass.new(update, @controller_path, @action).send(@action)
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
        @controller_klass ||= "#{ @controller_path.camelize }Controller".constantize
      end
    end
  end
end
