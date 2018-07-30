# frozen_string_literal: true

FactoryGirl.define do
  sequence(:position) { |n| 100 + n }

  factory :assessment_case do
    position
    description "MyText"
    type "BaselineAssessmentCase"
  end
end
