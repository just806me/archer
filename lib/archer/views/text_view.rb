module Archer
  module Views
    class TextView
      def initialize path
        @path = path
      end

      def render_for binding
        @content ||= File.read @path
      end
    end
  end
end
