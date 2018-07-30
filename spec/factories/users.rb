# frozen_string_literal: true

FactoryGirl.define do
  sequence(:user_email) { |n| "user#{n}@example.com" }

  factory :user do
    email { generate(:user_email) }
    password "secrets!"
    confirmed_at Time.zone.now
  end
end
