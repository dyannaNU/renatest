# frozen_string_literal: true

require "rails_helper"

module Concerns
  RSpec.describe TokenValidator, type: :concern do
    describe "when a token exists" do
      let!(:token) { create :access_token, token: "foo" }

      describe "#valid?" do
        it "returns `true` when tokens match" do
          expect(TokenValidator.new("foo").valid?)
            .to eq true
        end

        it "returns `false` when tokens do not match" do
          expect(TokenValidator.new("bar").valid?)
            .to eq false
        end
      end
    end

    describe "when a token does not exist" do
      describe "#valid?" do
        it "returns `false` when tokens do not match" do
          expect(TokenValidator.new("foo").valid?)
            .to eq false
        end
      end
    end
  end
end
