require 'minitest/autorun'
require 'minitest/pride'
require "sinatra/base"
require_relative '../lib/ideabox.rb'
require "rack/test"
require "nokogiri"

class IdeaBoxTest < Minitest::Test
  include Rack::Test::Methods

  def app
    IdeaBoxApp.new
  end

  def test_index_route_works
    get '/'
    assert last_response.ok?
  end
end
