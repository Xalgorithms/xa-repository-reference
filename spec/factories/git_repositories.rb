FactoryGirl.define do
  factory :git_repository do
    url { Faker::Internet.url }
  end
end
