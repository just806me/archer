module Archer
  module Views
    class RenderedView
      def initialize path
        @path = path
      end

      def render_for binding
        renderer.result binding
      end

      private
      def renderer
        @renderer ||= ERB.new File.read @path
      end
    end
  end
end
