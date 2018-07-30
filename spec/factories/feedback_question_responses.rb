# frozen_string_literal: true

FactoryGirl.define do
  factory :feedback_question_response do
    participant
    feedback_question
    response_choice "MyString"
  end
end
