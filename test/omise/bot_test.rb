require 'test_helper'

class Omise::BotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Omise::Bot::VERSION
  end
end
