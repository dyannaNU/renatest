# frozen_string_literal: true

FactoryGirl.define do
  factory :story do
    file_name "MyString"
    identifier "MyString"
    skill { Skill.find_or_create_by(title: "MyString") }
  end
end
