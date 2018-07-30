# frozen_string_literal: true

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :case_file do
    assessment_case
    title "MyString"
    description "MyString"
    asset do
      fixture_file_upload(
        Rails.root.join("spec", "support", "assets", "test.mva")
      )
    end
  end
end
