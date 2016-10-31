FactoryGirl.define do
  factory :events_git_repository_destroy, class: Events::GitRepositoryDestroy do
    git_repository_id { UUID.generate }
  end
end
