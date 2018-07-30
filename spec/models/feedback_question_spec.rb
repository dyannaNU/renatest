# frozen_string_literal: true

require "rails_helper"

RSpec.describe FeedbackQuestion, type: :model do
  let(:feedback_question) { create :feedback_question }

  describe "validations" do
    it { expect(feedback_question).to be_valid }

    describe "invalid with no type" do
      before { feedback_question.type = nil }

      it { expect(feedback_question).to_not be_valid }
    end

    describe "invalid with no description" do
      before { feedback_question.description = nil }

      it { expect(feedback_question).to_not be_valid }
    end

    describe "invalid with no response_options" do
      before { feedback_question.response_options = nil }

      it { expect(feedback_question).to_not be_valid }
    end
  end
end
