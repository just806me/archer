module Archer
  module Views
    class ViewFinder
      def initialize controller_path, action
        @controller_path = controller_path

        @action = action
      end

      def find
        find_rendered_view || find_text_view
      end

      private
      def path
        @path ||= File.join CONFIG.root_dir, 'app', 'views', @controller_path
      end

      def find_rendered_view
        file = File.join path, "#{ @action }.txt.erb"

        RenderedView.new file if File.exists? file
      end

      def find_text_view
        file = File.join path, "#{ @action }.txt"

        TextView.new file if File.exists? file
      end
    end
  end
end
