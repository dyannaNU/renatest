# frozen_string_literal: true

require "rails_helper"

RSpec.describe AssessmentQuestion, type: :model do
  let(:assessment_question) { create :assessment_question }

  describe "validations" do
    it { expect(assessment_question).to be_valid }

    describe "invalid with no position" do
      before { assessment_question.position = nil }

      it { expect(assessment_question).to_not be_valid }
    end

    describe "invalid with no skill" do
      before { assessment_question.skill = nil }

      it { expect(assessment_question).to_not be_valid }
    end

    describe "invalid with no description" do
      before { assessment_question.description = nil }

      it { expect(assessment_question).to_not be_valid }
    end

    describe "invalid when position is not unique" do
      it do
        assessment_question
        another_assessment_question = AssessmentQuestion.new(
          position: assessment_question.position,
          description: "foo"
        )
        expect(another_assessment_question).to_not be_valid
        expect(another_assessment_question.errors.messages[:position])
          .to include "has already been taken"
      end
    end
  end
end
