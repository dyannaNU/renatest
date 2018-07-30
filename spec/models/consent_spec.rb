# frozen_string_literal: true

require "rails_helper"

RSpec.describe Consent, type: :model do
  let(:consent) { create :consent }

  describe "validations" do
    it { expect(consent).to be_valid }

    describe "is invalid with no participant" do
      before { consent.participant = nil }

      it { expect(consent).to_not be_valid }
    end

    describe "is invalid with no response" do
      before { consent.response = nil }

      it { expect(consent).to_not be_valid }
    end
  end
end
