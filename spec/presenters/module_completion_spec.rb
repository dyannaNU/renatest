# frozen_string_literal: true

require "rails_helper"
RSpec.describe ModuleCompletion, type: :presenter do
  let(:participant) { create :participant }
  let!(:story1) { create :story, identifier: "Story1" }
  let!(:story2) { create :story, identifier: "Story2" }
  let(:presenter) do
    ModuleCompletion.new(participant: participant,
                         stories: Story,
                         baseline_assessment_cases: BaselineAssessmentCase)
  end

  describe "#completed_modules?" do
    before do
      create :page_view_event,
             type: HowToViewEvent.to_s, participant: participant
    end

    describe "when no modules have been completed" do
      it "returns false" do
        create_baseline_cases
        create_high_benchmark(participant, story1.skill)
        complete_baselines(participant, BaselineAssessmentCase)

        expect(presenter.completed_modules?).to be false
      end
    end

    describe "when one required module has been completed" do
      it "returns false" do
        create_baseline_cases
        create_high_benchmark(participant, story1.skill)
        complete_baselines(participant, BaselineAssessmentCase)
        complete_module(participant, story1)

        expect(presenter.completed_modules?).to be false
      end
    end

    describe "when a non-required module has been completed" do
      it "returns false" do
        create_baseline_cases
        create_low_benchmark(participant, story1.skill)
        complete_baselines(participant, BaselineAssessmentCase)
        complete_module(participant, story1)

        expect(presenter.completed_modules?).to be false
      end
    end

    describe "when all required modules are completed" do
      it "returns true" do
        create_baseline_cases
        create_high_benchmark(participant, story1.skill)
        complete_baselines(participant, BaselineAssessmentCase)
        complete_module(participant, story1)
        complete_module(participant, story2)

        expect(presenter.completed_modules?).to be true
      end
    end
  end
end

def create_baseline_cases
  create :assessment_case,
         type: BaselineAssessmentCase.to_s
  create :assessment_case,
         type: BaselineAssessmentCase.to_s
end

def create_high_benchmark(participant, skill)
  create :benchmark_score,
         skill: skill,
         training_status: participant.training_status,
         percentage: 100
end

def create_low_benchmark(participant, skill)
  create :benchmark_score,
         skill: skill,
         training_status: participant.training_status,
         percentage: 1
end

def complete_module(participant, story)
  create :story_event,
         participant: participant,
         story: story
end

def complete_baselines(participant, klass)
  klass.all.each do |assessment_case|
    create :assessment_question_response,
           assessment_case: assessment_case,
           participant: participant
  end
end
