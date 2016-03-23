require "omise/service"

module Omise
  class User
    def initialize(name, service = Service.new)
      @name = normalize_name(name.to_s)
      @service = service
    end

    def name
      @name
    end

    def user?
      true
    end

    private

    def normalize_name(name)
      name
    end
  end
end
