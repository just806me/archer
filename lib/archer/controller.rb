module Archer
  class Controller
    delegate :helper_methods, to: :class

    def initialize update
      @update = update
    end

    def binding
      @binding ||= binding_module.get_binding
    end

    private
    def binding_module
      unless @binding_module.present?
        @binding_module = Module.new do
          extend Views::ViewHelper

          extend self
        end

        helper_methods.each do |method|
          @binding_module.define_singleton_method(method) { @controller.__send__ method }
        end

        @binding_module.instance_variable_set :@controller, self
      end


      @binding_module
    end

    class << self
      def helper_methods
        @helper_methods ||= []
      end

      def helper_method method
        helper_methods << method.to_sym
      end
    end
  end
end
