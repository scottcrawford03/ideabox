require 'minitest/autorun'
require 'minitest/pride'
require "sinatra/base"
require "sinatra/contrib"
require "sinatra/partial"
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

  def test_edit_route_works
    get '/:id/edit'
    assert last_response.ok?
  end

  def test_index_route_has_header
    get '/'
    html = Nokogiri::HTML(last_response.body)
    assert html.css('h1').to_s.include?('IdeaCAGE')
  end

  def test_index_route_has_existing_ideas
    get '/'
    html = Nokogiri::HTML(last_response.body)
    assert html.css('h3').to_s.include?('Existing')
  end

  def test_all_tags_works
    get '/tags'
    assert last_response.ok?
  end

  def test_tag_route_has_existing_ideas
    get '/tags'
    html = Nokogiri::HTML(last_response.body)
    assert html.css('h1').to_s.include?('Tags')
  end

  def test_single_tags_works
    get '/tags/:tag'
    assert last_response.ok?
  end

  def test_idea_versions_works
    get '/:id/versions'
    assert last_response.ok?
  end
end
