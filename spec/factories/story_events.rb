# frozen_string_literal: true

FactoryGirl.define do
  factory :story_event do
    completed_at "2017-05-11 09:14:18"
    participant
    story
  end
end
