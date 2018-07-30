# frozen_string_literal: true

FactoryGirl.define do
  factory :assessment_question_response do
    participant
    assessment_case
    assessment_question
  end
end
