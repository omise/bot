require "omise/service"
require "omise/channel"
require "omise/user"
require "rest-client"
require "json"

module Omise
  class Slack < Service
    BASE_URL = "https://slack.com/api/chat.postMessage?token=%{token}"

    def initialize(token, settings = {})
      raise TokenMissing.new("Where is the token dude?") if token.nil?
      @url = BASE_URL % { token: token }
      @settings = settings
      @online = true
    end

    attr_writer :online
    attr_reader :settings

    def post(text, options = {})
      request = [@url, { text: text }.merge(@settings).merge(options)]

      if @online
        RestClient.post(*request)
      else
        request
      end
    end

    def open_channel(name)
      Omise::Slack::Channel.new(name, self)
    end

    def build_user(name)
      Omise::Slack::User.new(name, self)
    end

    class Channel < Omise::Channel
      def post(text, options = {})
        super text, options.merge(channel: name)
      end

      private

      def normalize_name(name)
        if name == "directmessage" || name == "privategroup"
          "#random"
        else
          ["#", name].join
        end
      end
    end

    class User < Omise::User
      private

      def normalize_name(name)
        ["@", name].join
      end
    end
  end
end
