FactoryGirl.define do
  factory :events_git_repository_add, class: Events::GitRepositoryAdd do
    url { Faker::Internet.url }
    name { Faker::Hipster.word }
  end
end
