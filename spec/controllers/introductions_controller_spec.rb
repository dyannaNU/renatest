# frozen_string_literal: true

require "rails_helper"

RSpec.describe IntroductionsController, type: :controller do
  let(:participant) { create :participant }

  before do
    AssessmentCase.destroy_all
  end

  describe "GET #show" do
    before do
      create :consent, participant: participant
      sign_in participant
    end

    describe "when the type is baseline assessment" do
      before do
        create :assessment_case, type: BaselineAssessmentCase.to_s, position: 1
        get :show, params: { type: BaselineAssessmentCase.to_s }
      end

      it "renders baseline introduction show page" do
        expect(response)
          .to render_template "introductions/baseline_assessment_cases/show"
      end
    end

    describe "when the type is final assessment" do
      before do
        create :assessment_case, type: FinalAssessmentCase.to_s, position: 1
        get :show, params: { type: FinalAssessmentCase.to_s }
      end

      it "renders baseline introduction show page" do
        expect(response)
          .to render_template "introductions/final_assessment_cases/show"
      end
    end

    describe "when the type is incomplete" do
      before do
        get :show, params: { type: "foo" }
      end

      it "redirects home" do
        expect(response)
          .to redirect_to home_path
      end

      it "redirects home" do
        expect(flash[:alert])
          .to eq "There was an error: wrong constant name foo"
      end
    end
  end

  describe "PUT #update" do
    describe "when the type is baseline assessment" do
      let!(:first_case) do
        create :assessment_case, type: BaselineAssessmentCase.to_s, position: 1
      end

      describe "when update succeeds" do
        before do
          create :consent, participant: participant
          sign_in participant
          put :update, params: { type: BaselineAssessmentCase.to_s }
        end

        it "redirects to the first baseline assessment case" do
          expect(response)
            .to redirect_to assessment_case_path(
              first_case,
              type: BaselineAssessmentCase.to_s
            )
        end
      end

      describe "when update fails" do
        let(:errors) do
          double("errors", full_messages: %w[foo bar])
        end
        let(:participant) do
          create(:participant, consent: create(:consent)).tap do |participant|
            allow(participant)
              .to receive_messages(update: false, errors: errors)
          end
        end

        before do
          expect(request.env["warden"])
            .to receive(:authenticate!) { participant }
          allow(controller)
            .to receive(:current_participant) { participant }
          put :update, params: { type: BaselineAssessmentCase.to_s }
        end

        it "renders baseline introduction show page" do
          expect(response)
            .to render_template "introductions/baseline_assessment_cases/show"
        end

        it "displays error message" do
          expect(flash[:alert])
            .to eq "There was an error: foo and bar"
        end
      end
    end
  end
end
