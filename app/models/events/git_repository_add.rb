module Events
  class GitRepositoryAdd < Event
    field :name, type: String
    field :url, type: String

    belongs_to :git_repository
    
    after_create do |e|
      EventService.git_repository_add(e._id.to_s)
    end
  end
end
