FactoryGirl.define do
  factory :version do
    content { {} }
    code { Faker::Number.number(6) }
  end
end
