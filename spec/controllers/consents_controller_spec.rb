# frozen_string_literal: true

require "rails_helper"

RSpec.describe ConsentsController, type: :controller do
  let(:participant) { create :participant }

  describe "GET #new" do
    context "when no consent record previously exists" do
      before do
        sign_in participant
        get :new
      end

      it { expect(response).to be_success }
    end

    context "when a consent record previously exists" do
      before do
        create :consent, participant: participant
        sign_in participant
        get :new
      end

      it { expect(response).to redirect_to home_path }
    end
  end

  describe "POST #create" do
    before { sign_in participant }

    context "with valid params" do
      it "creates a new consent" do
        expect do
          post :create
        end.to change(Consent, :count).by(1)
      end
    end
  end
end
