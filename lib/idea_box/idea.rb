class Idea
  include Comparable
  attr_reader :title,
              :description,
              :rank,
              :id,
              :tag,
              :version,
              :history,
              :created_at,
              :day_created,
              :time_created

  def initialize(attributes)
    @title        = attributes['title']
    @description  = attributes['description']
    @rank         = attributes['rank'] || 0
    @id           = attributes['id']
    @tag          = attributes['tag']
    @version      = attributes['version'] || 0
    @history      = attributes['history'] || []
    @created_at   = attributes['created_at'] || Time.new
    @day_created  = created_at.strftime('%A')
    @time_created = created_at.strftime('%l:%M %p')
  end

  def save
    IdeaStore.create(to_h)
  end

  def to_h
    {
      "title"        => title,
      "description"  => description,
      "rank"         => rank,
      "tag"          => tag,
      "version"      => version,
      "created_at"   => created_at,
      "day_created"  => day_created,
      "time_created" => time_created,
      "history"      => history
    }
  end

  def like!
    @rank += 1
  end

  def update!(params, idea)
    @history << idea
    @created_at  = Time.new
    @title       = params["title"]
    @description = params["description"]
    @tag         = params["tag"]
    @version += 1
  end

  def <=>(other)
    other.rank <=> rank
  end
end
