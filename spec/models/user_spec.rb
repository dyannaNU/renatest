# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "creation" do
    it "sets a password" do
      user = User.create!(email: "foo@bar.com")

      expect(user.encrypted_password).to be_present
    end
  end
end
