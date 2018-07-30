# frozen_string_literal: true

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :module_file do
    title "MyString"
    description "MyString"
    asset do
      fixture_file_upload(
        Rails.root.join("spec", "support", "assets", "test.mva")
      )
    end
  end
end
