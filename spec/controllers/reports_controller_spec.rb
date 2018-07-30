# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReportsController, type: :controller do
  let(:participant) { create :participant }
  let(:assessment_case_1) { create :assessment_case }
  let(:assessment_case_2) { create :assessment_case }
  let(:assessment_case_3) do
    create :assessment_case,
           type: "FinalAssessmentCase"
  end
  let(:assessment_case_4) do
    create :assessment_case,
           type: "FinalAssessmentCase"
  end
  let(:assessment_question_1) { create :assessment_question }
  let(:assessment_question_2) { create :assessment_question }

  before do
    create :consent, participant: participant
    create :story_event, participant: participant
    create :assessment_question_response,
           participant: participant,
           assessment_case: assessment_case_1,
           assessment_question: assessment_question_1
    create :assessment_question_response,
           participant: participant,
           assessment_case: assessment_case_1,
           assessment_question: assessment_question_2
    create :assessment_question_response,
           participant: participant,
           assessment_case: assessment_case_2,
           assessment_question: assessment_question_1
    create :assessment_question_response,
           participant: participant,
           assessment_case: assessment_case_2,
           assessment_question: assessment_question_2
    sign_in participant
  end

  describe "GET #generate_single_participant_report" do
    before do
      get :generate_single_participant_report,
          params: { participant_id: participant.id }
    end

    it { expect(response).to have_http_status(200) }

    it "sends the right data to csv" do
      expect(assigns(:data)).to include("Foo Bar")
      expect(assigns(:data)).to include("trainee")
      expect(assigns(:data)).to include("FooBar")
      expect(assigns(:data)).to include("N")
      expect(assigns(:data)).to include("Y")
    end

    it "generates a csv" do
      expect(response.header["Content-Type"]).to include "text/csv"
    end
  end

  describe "GET #generate_full_report" do
    before { get :generate_full_report }

    it { expect(response).to have_http_status(200) }

    it "sends the right data to csv" do
      expect(assigns(:data)).to include("Foo Bar")
      expect(assigns(:data)).to include("trainee")
      expect(assigns(:data)).to include("FooBar")
      expect(assigns(:data)).to include("N")
      expect(assigns(:data)).to include("Y")
    end

    it "generates a csv" do
      expect(response.header["Content-Type"]).to include "text/csv"
    end
  end
end
