# frozen_string_literal: true

require "rails_helper"

RSpec.describe FinalReportCardsController, type: :controller do
  let(:participant) { create :participant }

  before do
    create :consent, participant: participant
    sign_in participant
  end

  describe "GET #show" do
    before { get :show }

    it { expect(response).to be_success }
  end

  describe "GET #attach" do
    before { get :attach }

    it { expect(response).to redirect_to final_report_card_url }
  end
end
