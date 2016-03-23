require "omise/service"
require "octokit"

module Omise
  class GitHub < Service
    def initialize(token = nil)
      raise TokenMissing.new("Where is the token dude?") if token.nil?
      @client = Octokit::Client.new(access_token: token)
    end

    def pull_requests(repo, options = {})
      @client.pull_requests(repo, options)
    end

    def contributors(repo)
      @client.contributors(repo)
    end
  end
end
