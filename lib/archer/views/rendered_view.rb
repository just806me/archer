module Archer
  module Views
    class RenderedView < TextView
      private
      def content
        @content ||= renderer.result binding
      end

      def renderer
        @renderer ||= ERB.new File.read @path
      end

      def binding
        @binding ||= ViewHelper.instance_eval { binding }
      end
    end
  end
end
