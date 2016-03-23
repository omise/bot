require "omise/service"

module Omise
  class Channel
    def initialize(name, service = Service.new)
      @name = normalize_name(name.to_s)
      @service = service
    end

    def post(text, options = {})
      @service.post(text, options)
    end

    def name
      @name
    end

    def channel?
      true
    end

    private

    def normalize_name(name)
      name
    end
  end
end
