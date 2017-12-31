module Archer
  class Renderer
    attr_reader :klass_name

    def initialize klass
      @klass_name = klass.name
    end

    def render
      erb.result binding
    end

    private
    def binding
      @binding ||= ViewHelper.instance_eval { binding }
    end

    def erb
      @erb ||= ERB.new template
    end

    def template
      @template ||= File.read view_path
    end

    def view_path
      @view_path ||= File.join Config.root_dir, 'app', 'views', view_name
    end

    def view_name
      @view_name ||= "#{ klass_name.remove(/Handler\z/).downcase }.txt.erb"
    end
  end
end
