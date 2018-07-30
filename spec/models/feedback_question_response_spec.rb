# frozen_string_literal: true

require "rails_helper"

RSpec.describe FeedbackQuestionResponse, type: :model do
  let(:feedback_question_response) { create :feedback_question_response }

  describe "validations" do
    it { expect(feedback_question_response).to be_valid }

    describe "invalid with no participant" do
      before { feedback_question_response.participant = nil }

      it { expect(feedback_question_response).to_not be_valid }
    end

    describe "invalid with no feedback_question" do
      before { feedback_question_response.feedback_question = nil }

      it { expect(feedback_question_response).to_not be_valid }
    end

    describe "invalid with no response_choice" do
      before { feedback_question_response.response_choice = nil }

      it { expect(feedback_question_response).to_not be_valid }
    end
  end
end
