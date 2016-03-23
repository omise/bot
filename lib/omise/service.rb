module Omise
  class Service
    TokenMissing = Class.new(ArgumentError)

    attr_accessor :bot

    def post(text, options = {})
      print text
    end
  end
end
