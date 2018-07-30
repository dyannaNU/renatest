# frozen_string_literal: true

FactoryGirl.define do
  factory :feedback_question do
    type BaselineFeedbackQuestion.to_s
    description "MyString"
    response_options %w[foo bar baz]
  end
end
