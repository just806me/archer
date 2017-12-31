module Archer
  class HandlerSearcher
    attr_reader :update

    def initialize update
      @update = update
    end

    def handler
      return if handler_klass.blank?

      @handler ||= handler_klass.new update
    end

    private
    def handler_klass
      @handler_klass ||= HANDLERS.detect { |handler| handler.can_handle? update }
    end
  end
end
