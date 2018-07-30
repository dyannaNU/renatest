# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Registration" do
  let(:registration) { Pages::Participants::Registrations::New.new }
  let(:edit_registration) { Pages::Participants::Registrations::Edit.new }
  let(:access_token) { create :access_token }

  describe "when visiting the registration page" do
    before do
      clear_emails
      registration.load
    end

    scenario "Participant can sign up with correct flash messages" do
      registration
        .click_sign_in
        .fill_in_form(token: access_token.token, email: "monkey@banana.co")
        .click_sign_in

      expect(page)
        .to have_text "A message with a confirmation link has "\
                      "been sent to your email address. "\
                      "Please follow the link to activate your account."

      visit extract_confirmation_path_from_email

      expect(page)
        .to have_text "Your email address has been successfully confirmed."

      clear_emails
      registration
        .click_forgotten_password_link
        .fill_in_forgot_password("monkey@banana.co")
      visit extract_reset_password_path_from_email
      registration.update_password

      expect(page)
        .to have_text "Your password has been changed successfully. "\
                      "You are now signed in."

      registration
        .concede
        .log_out

      expect(page)
        .to have_text "Signed out successfully."

      participant = Participant.find_by(email: "monkey@banana.co")
      expect(participant.first_name)
        .to eq "Foo"
      expect(participant.last_name)
        .to eq "Bar"
      expect(participant.affiliation)
        .to eq "Important"
      expect(participant.training_status.title)
        .to eq "trainee"
    end
  end

  describe "when editing the registration" do
    let(:participant) do
      create :participant,
             first_name: "Foo",
             last_name: "Bar",
             affiliation: "FooBar",
             training_status: TrainingStatus.find_by(title: "trainee")
    end

    before do
      create :consent, participant: participant
      sign_in participant
    end

    scenario "can edit information" do
      edit_registration.load
      edit_registration.fill_in_form(
        password: participant.password,
        first_name: "Johnny",
        last_name: "Appleseed",
        affiliation: "The forest",
        training_status: "Unsupervised practice"
      )
      edit_registration.submit

      participant.reload

      expect(participant.first_name).to eq "Johnny"
      expect(participant.last_name).to eq "Appleseed"
      expect(participant.affiliation).to eq "The forest"
      expect(participant.training_status.title).to eq "unsupervised practice"
    end
  end
end
