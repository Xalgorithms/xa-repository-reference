FactoryGirl.define do
  factory :trial do
    label { Faker::Hipster.word }
    version { Faker::Number.hexadecimal(6) }
  end
end
