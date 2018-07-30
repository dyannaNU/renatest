# frozen_string_literal: true

require "rails_helper"

RSpec.describe HowToGuidesController, type: :controller do
  let(:participant) { create :participant }

  before do
    create :consent, participant: participant
    sign_in participant
  end

  describe "GET #show" do
    it "creates a how to view event" do
      expect { get :show }.to change(HowToViewEvent, :count).by(1)
    end
  end
end
