# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Access token" do
  let(:user) { create :user }
  let(:new_token_access) { Pages::Users::NewTokenAccess.new }
  let(:edit_token_access) { Pages::Users::EditTokenAccess.new }

  before { sign_in user }

  context "no tokens exist" do
    scenario "user saves a random token" do
      new_token_access.goto
      new_token_access.click_save

      expect(new_token_access)
        .to have_text "Access token successfully created"
    end
  end

  context "a token exists" do
    let!(:access_token) { create :access_token }

    scenario "user can update a token" do
      edit_token_access.goto(access_token.to_param)
      edit_token_access.update_text "foo"
      edit_token_access.click_save

      expect(new_token_access)
        .to have_text "foo"
      expect(new_token_access)
        .to have_text "Access token successfully updated"
    end
  end
end
