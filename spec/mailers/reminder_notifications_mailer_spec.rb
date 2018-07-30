# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReminderNotificationsMailer, type: :mailer do
  let(:host) { "asdf.com" }
  let(:participant_email) { "participant.email@example.com" }
  let(:participant) { create :participant }

  before do
    Rails.configuration.action_mailer.default_url_options[:host] = host
  end

  describe "#reminder_notification" do
    let(:mail) do
      ReminderNotificationsMailer
        .reminder_notification(participant: participant)
    end

    it "sets 'subject'" do
      expect(mail.subject).to eq ReminderNotificationsMailer::REMINDER_SUBJECT
    end

    it "sets 'to' as participant's email" do
      expect(mail.to).to eq [participant.email]
    end

    it "sets 'from' as default" do
      expect(mail.from).to eq [ApplicationMailer::DEFAULT_FROM]
    end
  end
end
