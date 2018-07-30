# frozen_string_literal: true

FactoryGirl.define do
  sequence(:participant_email) { |n| "participant#{n}@example.com" }

  factory :participant do
    email { generate(:participant_email) }
    first_name "Foo"
    last_name "Bar"
    affiliation "FooBar"
    training_status { TrainingStatus.find_or_create_by(title: "trainee") }
    password "secrets!"
    password_confirmation "secrets!"
    confirmed_at Time.zone.now
  end
end
