FactoryGirl.define do
  factory :rule do
    name { Faker::Hipster.word }
    namespace { create(:namespace) }
  end
end
