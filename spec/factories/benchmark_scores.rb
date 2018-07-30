# frozen_string_literal: true

FactoryGirl.define do
  factory :benchmark_score do
    skill { Skill.find_or_create_by(title: "MyString") }
    training_status { TrainingStatus.find_or_create_by(title: "trainee") }
    percentage 1
  end
end
