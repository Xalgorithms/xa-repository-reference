FactoryGirl.define do
  factory :trial_table do
    name { Faker::Hipster.word }
    content { [] }
  end
end
