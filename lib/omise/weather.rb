require "omise/service"
require "json"
require "rest-client"

module Omise
  class Weather < Service
    def initialize(city)
      @city = city
    end

    def temperature
      temp = Integer(main["temp"])
      (temp / 10).round
    end

    def humidity
      Integer(main["humidity"])
    end

    def name
      weather["main"]
    end

    def description
      weather["description"]
    end

    def icon
      weather["icon"]
    end

    def location
      data["name"]
    end

    private

    def weather
      data["weather"].first
    end

    def main
      data["main"]
    end

    def data
      @data = JSON.load(RestClient.get("http://api.openweathermap.org/data/2.5/weather?q=#{@city}"))
    end
  end
end
