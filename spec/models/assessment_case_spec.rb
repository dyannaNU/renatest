# frozen_string_literal: true

require "rails_helper"

RSpec.describe AssessmentCase, type: :model do
  let(:assessment_case) { create :assessment_case }

  describe "validation" do
    it { expect(assessment_case).to be_valid }

    describe "invalid with no position" do
      before { assessment_case.position = nil }

      it { expect(assessment_case).to_not be_valid }
    end

    describe "invalid with no description" do
      before { assessment_case.description = nil }

      it { expect(assessment_case).to_not be_valid }
    end

    describe "invalid with no type" do
      before { assessment_case.type = nil }

      it { expect(assessment_case).to_not be_valid }
    end

    describe "invalid when position is not unique" do
      it do
        assessment_case
        another_assessment_case = AssessmentCase.new(
          position: assessment_case.position,
          type: "BaselineAssessmentCase",
          description: "foo"
        )
        expect(another_assessment_case).to_not be_valid
        expect(another_assessment_case.errors.messages[:position])
          .to include "has already been taken"
      end
    end

    describe "invalid when type is not included in Baseline and Final" do
      before { assessment_case.type = "foo" }

      it { expect(assessment_case).to_not be_valid }
    end
  end
end
