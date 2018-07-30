# frozen_string_literal: true

require "rails_helper"

RSpec.describe AccessToken, type: :model do
  let(:access_token) { create :access_token }

  describe "validations" do
    it { expect(access_token).to be_valid }

    describe "invalid with no token" do
      before { access_token.token = nil }

      it { expect(access_token).to be_invalid }
    end
  end
end
