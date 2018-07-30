# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReportCard do
  describe "#percent_correct" do
    def participant_with_correct_responses(count)
      instance_double Participant, correct_responses_for_case: (1..count).to_a
    end

    def case_with_questions(count)
      instance_double AssessmentCase, questions: (1..count).to_a
    end

    context "when there are no questions" do
      it "returns 0" do
        report = ReportCard.new(participant_with_correct_responses(0))

        expect(report.percent_correct(case_with_questions(0))).to eq 0
      end
    end

    context "when there are no correct responses" do
      it "returns 0" do
        report = ReportCard.new(participant_with_correct_responses(0))

        expect(report.percent_correct(case_with_questions(3))).to eq 0
      end
    end

    context "when there are some correct responses" do
      it "returns the correct percent" do
        report = ReportCard.new(participant_with_correct_responses(1))

        expect(report.percent_correct(case_with_questions(3))).to eq 33
      end
    end

    context "when there are all correct responses" do
      it "returns 100" do
        report = ReportCard.new(participant_with_correct_responses(3))

        expect(report.percent_correct(case_with_questions(3))).to eq 100
      end
    end
  end
end
