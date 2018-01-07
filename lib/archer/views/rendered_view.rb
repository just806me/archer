module Archer
  module Views
    class RenderedView < TextView
      private
      def content
        renderer.result binding
      end

      def renderer
        @renderer ||= ERB.new File.read @path
      end

      def binding
        @binding ||= ViewHelper.get_binding
      end
    end
  end
end
