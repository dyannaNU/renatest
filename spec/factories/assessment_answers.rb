# frozen_string_literal: true

FactoryGirl.define do
  factory :assessment_answer do
    assessment_case
    assessment_question nil
    position "10"
    title "MyString"
    is_correct false
  end
end
