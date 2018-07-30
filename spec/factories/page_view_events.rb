# frozen_string_literal: true

FactoryGirl.define do
  factory :page_view_event do
    type HowToViewEvent.to_s
    participant
  end
end
