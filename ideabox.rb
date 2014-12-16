require "./idea"

class IdeaBoxApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  post '/' do
    idea = Idea.new
    "Creating an IDEA!"
  end

  not_found do
    erb :error
  end
end
