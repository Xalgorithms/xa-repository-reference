FactoryGirl.define do
  factory :rule do
    name { Faker::Hipster.word }
    namespace { create(:namespace) }
    rule_type { 'xalgo' }
  end
end
