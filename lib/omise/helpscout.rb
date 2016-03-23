require "omise/service"
require "json"
require "rest-client"

module Omise
  class HelpScout < Service
    SEARCH_PATH = "search/conversations.json?query=number:%{number}"
    CONVERSATION_PATH = "conversations/%{id}.json"

    TooManyResults = Class.new(StandardError)

    def initialize(users, token = nil)
      @users = users
      raise TokenMissing.new("Where is the token dude?") if token.nil?
      @client = RestClient::Resource.new("https://api.helpscout.net/v1/", token, "X")
    end

    def find_by_number(number)
      response = JSON.load(@client[SEARCH_PATH % { number: number }].get)
      if response["count"] == 1
        response["items"].first
      else
        raise TooManyResults
      end
    end

    def find_user_id(user)
      @users[user.name.delete("@").to_sym]
    end

    def reply(number, user_id, body)
      convo = find_by_number(number)
      id = convo["id"]
      @client[CONVERSATION_PATH % { id: id }].post({
        createdBy: {
          type: "user",
          id: user_id
        },
        body: body,
        type: "message",
      }.to_json, content_type: :json)
    end
  end
end
