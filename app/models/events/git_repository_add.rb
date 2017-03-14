module Events
  class GitRepositoryAdd < Event
    field :name, type: String
    field :url, type: String

    belongs_to :git_repository
  end
end
