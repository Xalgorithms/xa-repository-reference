FactoryGirl.define do
  factory :registry do
    url { Faker::Internet.url }
    public_id { UUID.generate }
    registered_public_id { UUID.generate }
  end
end
