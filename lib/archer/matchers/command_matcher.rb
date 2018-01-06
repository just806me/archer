module Archer
  module Matchers
    class CommandMatcher
      def initialize command, type
        @command = command

        @type = type
      end

      def match? update
        return false unless @type == update.type

        command_regex.match? update.data
      end

      private
      def command_regex
        @command_regex ||= /\A\/#{ @command }/
      end
    end
  end
end
