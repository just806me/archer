module Archer
  class Controller
    delegate :views, to: :class

    def initialize update, path, action
      @update, @path, @action = update, path, action
    end

    private
    def respond
      view.request_for(@update).send
    end

    def method_missing *args
      respond
    end

    def respond_to_missing? *args
      true
    end

    def view
      views[@action] ||= Views::ViewFinder.new(@path, @action).find
    end

    class << self
      def views
        @views ||= {}
      end
    end
  end
end
