module Events
  class GitRepositoryDestroy < Event
    field :git_repository_id, type: String

    after_create do |e|
      EventService.git_repository_destroy(e._id.to_s)
    end
  end
end
