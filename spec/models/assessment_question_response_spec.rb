# frozen_string_literal: true

require "rails_helper"

RSpec.describe AssessmentQuestionResponse, type: :model do
  let(:assessment_question_response) { create :assessment_question_response }

  describe "validations" do
    it { expect(assessment_question_response).to be_valid }

    describe "invalid with no participant" do
      before { assessment_question_response.participant = nil }

      it { expect(assessment_question_response).to_not be_valid }
    end

    describe "invalid with no assessment_case" do
      before { assessment_question_response.assessment_case = nil }

      it { expect(assessment_question_response).to_not be_valid }
    end

    describe "invalid with no assessment_question" do
      before { assessment_question_response.assessment_question = nil }

      it { expect(assessment_question_response).to_not be_valid }
    end
  end

  describe "scopes" do
    describe ".correct" do
      it "returns the responses that are correct" do
        assessment_question1 = create(:assessment_question)
        create(
          :assessment_answer,
          assessment_question: assessment_question1,
          is_correct: true
        )
        assessment_answer_1_f = create(
          :assessment_answer,
          assessment_question: assessment_question1,
          is_correct: false
        )
        assessment_question2 = create(:assessment_question)
        assessment_answer_2_t = create(
          :assessment_answer,
          assessment_question: assessment_question2,
          is_correct: true
        )
        create(
          :assessment_answer,
          assessment_question: assessment_question2,
          is_correct: false
        )
        incorrect_response = create(
          :assessment_question_response,
          assessment_question: assessment_question1,
          assessment_answer: assessment_answer_1_f
        )
        correct_response = create(
          :assessment_question_response,
          assessment_question: assessment_question2,
          assessment_answer: assessment_answer_2_t
        )
        correct_responses = AssessmentQuestionResponse.correct

        expect(correct_responses).to include correct_response
        expect(correct_responses).not_to include incorrect_response
      end
    end
  end
end
