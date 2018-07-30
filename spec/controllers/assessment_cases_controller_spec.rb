# frozen_string_literal: true

require "rails_helper"

RSpec.describe AssessmentCasesController, type: :controller do
  let(:participant) { create :participant }

  describe "GET #show" do
    before do
      create(:assessment_case)
      create :consent, participant: participant
      sign_in participant
    end

    it "will be fulfilled" do
      participant.update(assessment_case: BaselineAssessmentCase.first)
      get :show, params: {
        id: BaselineAssessmentCase.first.id,
        type: BaselineAssessmentCase.to_s
      }

      expect(response).to be_success
    end

    it "records a page event" do
      expect do
        get :show, params: {
          id: BaselineAssessmentCase.first.id,
          type: BaselineAssessmentCase.to_s
        }
      end.to change(BaselineAssessmentCaseViewEvent, :count).by(1)
    end

    describe "when already completed assessments" do
      before do
        BaselineAssessmentCase.find_each do |assessment_case|
          create :assessment_question_response,
                 assessment_case: assessment_case,
                 participant: participant
        end
      end

      it "redirects participant back to home page" do
        get :show, params: {
          id: BaselineAssessmentCase.first.id,
          type: BaselineAssessmentCase.to_s
        }

        expect(response)
          .to redirect_to home_path
      end
    end
  end
end
