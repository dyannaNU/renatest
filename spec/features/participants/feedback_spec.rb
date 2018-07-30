# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Feedback" do
  let(:participant) { create :participant }
  let(:home_page) { Pages::Home.new }
  let(:feedback) { Pages::Feedback.new }

  background do
    create :feedback_question, type: "BaselineFeedbackQuestion"
    create :consent, participant: participant
  end

  describe "when a participant has not completed the feedback" do
    background { sign_in participant }

    scenario "completes feedback" do
      feedback.load
      feedback.complete

      expect(home_page).to have_heading
    end
  end

  describe "when a participant has previously completed the feedback" do
    background do
      BaselineFeedbackQuestion.find_each do |question|
        create :feedback_question_response,
               participant: participant,
               feedback_question: question,
               response_choice: "foo"
      end
      sign_in participant
    end

    scenario "is redirected to home and is given notice of completion" do
      feedback.load

      expect(home_page).to have_heading
      expect(home_page)
        .to have_text "You have already completed the feedback questionnaire"
    end
  end
end
