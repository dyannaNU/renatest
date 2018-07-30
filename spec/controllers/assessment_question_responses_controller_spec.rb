# frozen_string_literal: true

require "rails_helper"

RSpec.describe AssessmentQuestionResponsesController, type: :controller do
  let(:participant) { create :participant }
  let(:assessment_case) { create :assessment_case }
  let(:final_assessment_case) do
    create :assessment_case, type: "FinalAssessmentCase"
  end
  let(:first_assessment_question) { create :assessment_question }
  let(:first_assessment_answer) do
    create(
      :assessment_answer,
      assessment_question: first_assessment_question,
      assessment_case: assessment_case
    )
  end
  let(:final_assessment_answer) do
    create(
      :assessment_answer,
      assessment_question: first_assessment_question,
      assessment_case: final_assessment_case
    )
  end
  let(:second_assessment_question) { create :assessment_question }
  let(:second_assessment_answer) do
    create(
      :assessment_answer,
      assessment_question: second_assessment_question,
      assessment_case: assessment_case
    )
  end
  let(:first_assessment_question_response) do
    create :assessment_question_response,
           assessment_question: first_assessment_question,
           participant: participant,
           assessment_case: assessment_case
  end
  let(:final_assessment_question_response) do
    create :assessment_question_response,
           assessment_question: first_assessment_question,
           participant: participant,
           assessment_case: final_assessment_case
  end

  let(:second_assessment_question_response) do
    create :assessment_question_response,
           assessment_question: second_assessment_question,
           participant: participant,
           assessment_case: assessment_case
  end

  let(:empty_attributes) do
    {
      first_assessment_question_response.id.to_s => {
        participant_id: participant.id,
        assessment_case_id: assessment_case.id,
        assessment_question_id: first_assessment_question.id,
        assessment_answer_id: ""
      },
      second_assessment_question_response.id.to_s => {
        participant_id: participant.id,
        assessment_case_id: assessment_case.id,
        assessment_question_id: second_assessment_question.id,
        assessment_answer_id: ""
      }
    }
  end

  let(:valid_attributes) do
    {
      first_assessment_question_response.id.to_s => {
        participant_id: participant.id,
        assessment_case_id: assessment_case.id,
        assessment_question_id: first_assessment_question.id,
        assessment_answer_id: first_assessment_answer.id
      },
      second_assessment_question_response.id.to_s => {
        participant_id: participant.id,
        assessment_case_id: assessment_case.id,
        assessment_question_id: second_assessment_question.id,
        assessment_answer_id: second_assessment_answer.id
      }
    }
  end

  let(:valid_final_assessment_attributes) do
    {
      final_assessment_question_response.id.to_s => {
        participant_id: participant.id,
        assessment_case_id: final_assessment_case.id,
        assessment_question_id: first_assessment_question.id,
        assessment_answer_id: final_assessment_answer.id
      }
    }
  end

  before do
    create :consent, participant: participant
    sign_in participant
  end

  describe "PUT #update_responses" do
    it "updates assessment_question_responses" do
      put :update_responses, params: {
        assessment_question_responses: valid_attributes,
        assessment_type: BaselineAssessmentCase.to_s
      }

      first_assessment_question_response.reload
      second_assessment_question_response.reload

      expect(first_assessment_question_response.assessment_answer_id)
        .to eq first_assessment_answer.id
      expect(second_assessment_question_response.assessment_answer_id)
        .to eq second_assessment_answer.id
    end

    context "when not all questions are answered" do
      it "renders the current case" do
        post :update_responses, params: {
          assessment_question_responses: empty_attributes,
          assessment_type: "BaselineAssessmentCase"
        }

        expect(response).to redirect_to(
          assessment_case_path(assessment_case, type: "BaselineAssessmentCase")
        )
      end
    end

    context "when the current case is the last one" do
      it "redirects to home" do
        post :update_responses, params: {
          assessment_question_responses: valid_attributes,
          assessment_type: "BaselineAssessmentCase"
        }

        expect(response)
          .to redirect_to baseline_congratulations_path
      end
    end

    context "when the current case is the last final assessment" do
      it "redirects to home" do
        post :update_responses, params: {
          assessment_question_responses: valid_final_assessment_attributes,
          assessment_type: "FinalAssessmentCase"
        }

        expect(response)
          .to redirect_to final_congratulations_path
      end
    end

    context "when the current case is not the last one" do
      def create_another_assessment_case
        create :assessment_case, position: assessment_case.position + 1
      end

      context "when the participant is continuing (Save & Next)" do
        it "redirects to the next case" do
          create_another_assessment_case
          post :update_responses, params: {
            assessment_question_responses: valid_attributes,
            assessment_type: "BaselineAssessmentCase"
          }

          expect(response).to redirect_to(
            assessment_case_path(
              AssessmentCase.find_by(position: assessment_case.position + 1),
              type: "BaselineAssessmentCase"
            )
          )
        end
      end

      context "when the participant is exiting (Save & Exit)" do
        it "stores the next case on the participant" do
          next_assessment_case = create_another_assessment_case

          post :update_responses, params: {
            assessment_question_responses: valid_attributes,
            assessment_type: "BaselineAssessmentCase",
            redirect_home: "true"
          }

          expect(participant.reload.assessment_case_id)
            .to eq(next_assessment_case.id)
          expect(participant.reload.assessment_case.type)
            .to eq(next_assessment_case.type)
        end
      end
    end
  end
end
