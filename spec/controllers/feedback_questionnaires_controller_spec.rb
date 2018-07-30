# frozen_string_literal: true

require "rails_helper"

RSpec.describe FeedbackQuestionnairesController, type: :controller do
  let(:participant) { create :participant }

  before { create :feedback_question, type: "BaselineFeedbackQuestion" }

  after { FeedbackQuestionResponse.destroy_all }

  describe "GET #show" do
    context "when a participant has not completed the feedback" do
      before do
        create :consent, participant: participant
        sign_in participant
        get :show, params: { type: "BaselineFeedbackQuestion" }
      end

      it { expect(response).to be_success }
    end

    context "when a participant has completed the feedback" do
      before do
        create :consent, participant: participant
        BaselineFeedbackQuestion.find_each do |question|
          create :feedback_question_response,
                 participant: participant,
                 feedback_question: question,
                 response_choice: "foo"
        end
        sign_in participant
        get :show, params: { type: BaselineFeedbackQuestion.to_s }
      end

      it { expect(response).to redirect_to home_path }
    end
  end
end
