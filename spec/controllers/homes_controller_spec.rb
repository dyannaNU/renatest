# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomesController, type: :controller do
  let(:participant) { create :participant }

  before { sign_in participant }

  describe "GET #show" do
    context "when the participant has no consent record" do
      before { get :show }

      it { expect(response).to redirect_to new_consent_path }
    end

    context "when the participant has consented" do
      before { create :consent, participant: participant }

      context "when the participant has no how to view event record" do
        before { get :show }

        it { expect(response).to be_success }
      end
    end
  end
end
