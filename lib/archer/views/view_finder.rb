module Archer
  module Views
    class ViewFinder
      def initialize controller, action
        @controller = controller

        @action = action
      end

      def find
        find_rendered_view || find_text_view
      end

      private
      def controller_folder
        @controller.class.name.remove(/Controller\z/).underscore
      end

      def path
        @path ||= File.join CONFIG.root_dir, 'app', 'views', controller_folder
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
