FactoryGirl.define do
  factory :git_repository do
    url { Faker::Internet.url }
    name { Faker::Hipster.word }
  end
end
