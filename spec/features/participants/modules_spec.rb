# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Modules" do
  let(:participant) { create :participant }
  let!(:story) do
    create :story,
           file_name: "PIP",
           identifier: "6PuBOzflYsU",
           skill: Skill.find_by(title: "Pressure Inversion Point")
  end

  before do
    create :consent, participant: participant
    create :page_view_event, type: "HowToViewEvent", participant: participant

    BaselineFeedbackQuestion.find_each do |question|
      create :feedback_question_response,
             participant: participant,
             feedback_question: question,
             response_choice: "foo"
    end

    AssessmentCase.find_each do |assessment_case|
      AssessmentQuestion.find_each do |assessment_question|
        create :assessment_question_response,
               participant: participant,
               assessment_case: assessment_case,
               assessment_question: assessment_question
      end
    end
    create :module_file
    sign_in participant
  end

  scenario "can download the module files" do
    visit modules_path
    click_on "Download Files Needed for Modules"

    expect(response_headers["Content-Type"]).to eq "application/zip"
  end

  scenario "view a module", js: true do
    visit modules_path
    new_window = window_opened_by do
      click_on "Pressure Inversion Point"
    end

    within_window new_window do
      expect(page)
        .to have_selector "div.framewrap"
    end
  end
end
