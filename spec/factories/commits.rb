FactoryGirl.define do
  factory :commit do
    version  { Faker::Number.hexadecimal(10) }
    added    { [] }
    removed  { [] }
    modified { [] }
  end
end
