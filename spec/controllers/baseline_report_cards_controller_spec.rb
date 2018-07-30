# frozen_string_literal: true

require "rails_helper"

RSpec.describe BaselineReportCardsController, type: :controller do
  let(:participant) { create :participant }

  before do
    create :consent, participant: participant
    sign_in participant
  end

  describe "GET #show" do
    before { get :show }

    it { expect(response).to be_success }
  end
end
