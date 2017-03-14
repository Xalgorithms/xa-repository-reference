module Events
  class GitRepositoryDestroy < Event
    field :git_repository_id, type: String
  end
end
