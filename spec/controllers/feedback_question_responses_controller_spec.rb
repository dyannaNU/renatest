# frozen_string_literal: true

require "rails_helper"

RSpec.describe FeedbackQuestionResponsesController, type: :controller do
  let(:participant) { create :participant }
  let(:feedback_question) do
    create :feedback_question, type: BaselineFeedbackQuestion.to_s
  end
  let(:valid_params) do
    {
      feedback_question_responses: {
        "0": {
          feedback_question_id: feedback_question.id,
          response_choice: "foo"
        }
      }, feedback_type: BaselineFeedbackQuestion.to_s
    }
  end

  let(:invalid_params) do
    {
      feedback_question_responses: {
        "0": {
          feedback_question_id: feedback_question.id,
          response_choice: nil
        }
      }, feedback_type: BaselineFeedbackQuestion.to_s
    }
  end

  before do
    create :consent, participant: participant
    sign_in participant
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new feedback question response" do
        expect do
          post :create, params: valid_params
        end.to change(FeedbackQuestionResponse, :count).by(1)
      end

      it "redirects to home" do
        post :create, params: valid_params

        expect(response).to redirect_to home_path
      end
    end

    context "with invalid params" do
      it "does not create a new feedback question response" do
        expect do
          post :create, params: invalid_params
        end.to change(FeedbackQuestionResponse, :count).by(0)
      end

      it "redirects to feedback_questionnaire" do
        post :create, params: invalid_params

        expect(response)
          .to redirect_to "/feedback_questionnaire?"\
                          "type=BaselineFeedbackQuestion"
      end
    end
  end
end
