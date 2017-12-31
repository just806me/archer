module Archer
  class HandlerSearcher
    attr_reader :update

    def initialize update
      @update = update
    end

    def handler
      @handler ||= find_handler.new update
    end

    private
    def find_handler
      HANDLERS.detect { |handler_class| handler_class.can_handle? update }
    end
  end
end
