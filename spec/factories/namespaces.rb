FactoryGirl.define do
  factory :namespace do
    name { Faker::Hipster.word }
  end
end
