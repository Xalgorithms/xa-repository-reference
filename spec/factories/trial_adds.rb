FactoryGirl.define do
  factory :events_trial_add, class: Events::TrialAdd do
    label { Faker::Internet.url }
  end
end
