module Archer
  class Controller
    VIEWS = {}

    delegate :render, to: :renderer

    def initialize update, action
      @update, @action = update, action
    end

    def process
      send @action
    end

    private
    def respond
      view.request_for(@update).send
    end

    def method_missing *args
      respond
    end

    def view
      VIEWS[@action] ||= Views::ViewFinder.new(self, @action).find
    end
  end
end
