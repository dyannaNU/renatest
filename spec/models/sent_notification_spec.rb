# frozen_string_literal: true

require "rails_helper"

RSpec.describe SentNotification, type: :model do
  let(:sent_notification) { create :sent_notification }

  describe "validations" do
    it { expect(sent_notification).to be_valid }

    describe "is invalid with no participant" do
      before { sent_notification.participant = nil }

      it { expect(sent_notification).to be_invalid }
    end
  end
end
