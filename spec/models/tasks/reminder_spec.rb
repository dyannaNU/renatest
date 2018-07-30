# frozen_string_literal: true

require "rails_helper"

module Tasks
  RSpec.describe Reminder, type: :model do
    let!(:participant1) { create :participant }
    let!(:participant2) { create :participant }
    let!(:participant3) { create :participant }

    describe ".send_reminder" do
      before do
        allow(Participant)
          .to receive(:receives_notification) { [participant1, participant2] }
      end

      it "successfully sends notification" do
        expect(Tasks::Reminder.send_reminder).to eq true
      end

      it "only sends for receives_notification participants" do
        expect(Tasks::Reminder).to receive(:send_email_for).with(participant1)

        expect(Tasks::Reminder).to receive(:send_email_for).with(participant2)

        expect(Tasks::Reminder)
          .to_not receive(:send_email_for).with(participant3)

        Tasks::Reminder.send_reminder
      end
    end

    describe ".send_email_for" do
      it "sends notification as email" do
        expect(Tasks::Reminder.send_email_for(participant1))
          .to be_a(Mail::Message)
      end

      it "creates a SentNotification record" do
        expect do
          Tasks::Reminder.send_email_for(participant1)
        end.to change(SentNotification, :count).by(1)
      end
    end
  end
end
