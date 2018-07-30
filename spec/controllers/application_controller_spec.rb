# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  let(:participant) { create :participant }

  controller do
    def index
      render plain: "foo"
    end
  end

  describe "by default" do
    context "when not consented" do
      before do
        sign_in participant
        get :index
      end

      it { expect(response).not_to be_success }
    end

    context "when consented" do
      before do
        create :consent, participant: participant
      end

      context "and within access period" do
        before do
          sign_in participant
          get :index
        end

        it { expect(response).to be_success }
      end

      context "and past the access period" do
        before do
          past = Time.zone.now - ApplicationController::ACCESS_PERIOD - 1.day
          # rubocop:disable Rails/SkipsModelValidations
          participant.update_column(:created_at, past)
          # rubocop:enable Rails/SkipsModelValidations
          sign_in participant
          get :index
        end

        it { expect(response).not_to be_success }
      end
    end
  end
end
