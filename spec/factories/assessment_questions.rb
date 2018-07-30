# frozen_string_literal: true

FactoryGirl.define do
  factory :assessment_question do
    position
    skill { Skill.find_or_create_by(title: "MyString") }
    description "MyString"

    factory :assessment_question_with_answers do
      after(:create) do |question|
        create_list :assessment_answer, 3, assessment_question: question
      end
    end
  end
end
