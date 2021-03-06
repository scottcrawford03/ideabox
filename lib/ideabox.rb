require_relative 'idea_box'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Partial
  set :partial_template_engine, :erb

  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all.sort}
  end

  post '/' do
    idea = Idea.new(params[:idea])
    idea.history << idea
    IdeaStore.create(idea.to_h)
    redirect '/'
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  put '/:id' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.update!(params[:idea], idea)
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  get '/tags' do
    erb :all_tags, locals: {grouped: IdeaStore.sort_tags }
  end

  get '/tags/:tag' do |tag|
    erb :tags, locals: {tag: tag, ideas: IdeaStore.same_tag(tag)}
  end

  get '/:id/versions' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :version, locals: {ideas: idea.history}
  end
end
