# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Consent" do
  let(:participant) { create :participant }
  let(:home) { Pages::Home.new }
  let(:consent_form) { Pages::ConsentForm.new }

  before { sign_in participant }

  context "a participant has not previously submitted a consent form" do
    scenario "successfully creates a consent" do
      consent_form.load
      consent_form.consent

      expect(home).to have_heading
    end
  end

  context "a participant has previously submitted a consent form" do
    scenario "gets redirected to the home page" do
      create :consent, participant: participant
      consent_form.load

      expect(home).to have_heading
    end
  end
end
