class Idea
  include Comparable
  attr_reader :title,
              :description,
              :rank,
              :id,
              :tag,
              :version,
              :history

  def initialize(attributes)
    @title       = attributes['title']
    @description = attributes['description']
    @rank        = attributes['rank'] || 0
    @id          = attributes['id']
    @tag         = attributes['tag']
    @version     = attributes['version'] || 0
    @history     = attributes['history'] || []
  end

  def save
    IdeaStore.create(to_h)
  end

  def to_h
    {
      "title"       => title,
      "description" => description,
      "rank"        => rank,
      "tag"         => tag,
      "version"     => version,
      "history"     => history
    }
  end

  def like!
    @rank += 1
  end

  def update!(params, idea)
    @history << idea
    @title = params["title"]
    @description = params["description"]
    @tag = params["tag"]
    @version += 1
  end

  def <=>(other)
    other.rank <=> rank
  end
end
