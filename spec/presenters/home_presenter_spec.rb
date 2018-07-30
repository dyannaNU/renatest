# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomesPresenter, type: :presenter do
  let(:participant) { create :participant }
  let(:view_context) do
    double(:view_context)
  end
  let(:presenter) do
    HomesPresenter.new(participant, view_context)
  end

  describe "#baseline_assessment_link" do
    describe "when how to event has been completed" do
      before do
        create :page_view_event,
               type: HowToViewEvent.to_s, participant: participant
        BaselineAssessmentCase.destroy_all
      end

      describe "when baseline assessments exist" do
        let!(:baseline_assessment_case1) do
          create :assessment_case,
                 type: BaselineAssessmentCase.to_s, position: 1
        end
        let!(:baseline_assessment_case2) do
          create :assessment_case,
                 type: BaselineAssessmentCase.to_s, position: 2
        end

        describe "no baseline assessments have been completed" do
          it "returns a link to the first baseline assessment" do
            expect(view_context)
              .to receive(:link_to)
              .with(
                "Baseline Assessment",
                "/introduction?type=BaselineAssessmentCase",
                class: "list-group-item list-group-item-action"
              )

            presenter.baseline_assessment_link
          end
        end

        describe "when one baseline assessment has been completed" do
          before do
            participant.update(assessment_case: baseline_assessment_case1)
            create :assessment_question_response,
                   assessment_case: baseline_assessment_case1,
                   participant: participant
          end

          it "returns a link to the current baseline assessment" do
            expect(view_context)
              .to receive(:link_to)
              .with(
                "Baseline Assessment",
                "/assessment_cases/#{baseline_assessment_case1.id}"\
                "?type=BaselineAssessmentCase",
                class: "list-group-item list-group-item-action"
              )

            presenter.baseline_assessment_link
          end
        end
      end

      describe "all baseline assessments have been completed" do
        before do
          complete_cases(participant, BaselineAssessmentCase)
        end

        it "returns `nil`" do
          expect(presenter.final_assessment_link)
            .to be_nil
        end
      end
    end
  end

  describe "#modules_link" do
    describe "when baseline has not been completed" do
      it "returns `nil`" do
        expect(presenter.modules_link)
          .to be_nil
      end
    end

    describe "when baseline has been completed" do
      before do
        create :page_view_event, participant: participant
        complete_cases(participant, BaselineAssessmentCase)
      end

      it "returns link to modules" do
        expect(view_context)
          .to receive(:link_to)
          .with(
            "Modules",
            "/modules",
            data: { turbolinks: false },
            class: "list-group-item list-group-item-action"
          )

        presenter.modules_link
      end

      describe "when a participant has visited a final assessment case" do
        let(:final_assessment_case) do
          FinalAssessmentCase.destroy_all
          create :assessment_case, type: FinalAssessmentCase.to_s, position: 1
        end

        before do
          create :assessment_question_response,
                 assessment_case: final_assessment_case,
                 participant: participant
        end

        it "returns `nil`" do
          expect(presenter.modules_link)
            .to be_nil
        end
      end
    end
  end

  describe "#final_assessment_link" do
    describe "when no modules have been viewed" do
      it "does not return a link to the final assessment" do
        expect(presenter.final_assessment_link)
          .to be_nil
      end
    end

    describe "when all modules have been completed" do
      before do
        FinalAssessmentCase.destroy_all
        complete_modules(participant)
      end

      describe "when final assessments exist" do
        let!(:final_assessment_case1) do
          create :assessment_case, type: FinalAssessmentCase.to_s, position: 1
        end
        let!(:final_assessment_case2) do
          create :assessment_case, type: FinalAssessmentCase.to_s, position: 2
        end

        describe "no final assessments have been completed" do
          it "returns a link to the first final assessment" do
            expect(view_context)
              .to receive(:link_to)
              .with(
                "Final Assessment",
                "/introduction?type=FinalAssessmentCase",
                class: "list-group-item list-group-item-action"
              )

            presenter.final_assessment_link
          end
        end

        describe "when one final assessment has been completed" do
          before do
            participant.update(assessment_case: final_assessment_case1)
            create :assessment_question_response,
                   assessment_case: final_assessment_case1,
                   participant: participant
          end

          it "returns a link to the current final assessment" do
            expect(view_context)
              .to receive(:link_to)
              .with(
                "Final Assessment",
                "/assessment_cases/#{final_assessment_case1.id}"\
                "?type=FinalAssessmentCase",
                class: "list-group-item list-group-item-action"
              )

            presenter.final_assessment_link
          end
        end
      end

      describe "all final assessments have been completed" do
        before do
          complete_cases(participant, FinalAssessmentCase)
        end

        it "returns `nil`" do
          expect(presenter.final_assessment_link)
            .to be_nil
        end
      end
    end
  end

  describe "#final_feedback_questionnaire_link" do
    describe "when the final assessment hasn't been answered" do
      it "does not return a link to the final feedback questionnaire" do
        expect(presenter.final_feedback_questionnaire_link)
          .to be_nil
      end
    end

    describe "when final assessment has been completed" do
      before do
        complete_cases(participant, FinalAssessmentCase)
      end

      it "returns a link to the final feedback questionnaire" do
        expect(view_context)
          .to receive(:link_to)
          .with(
            "Final Feedback Questionnaire",
            "/feedback_questionnaire?type=FinalFeedbackQuestion",
            class: "list-group-item list-group-item-action"
          )

        expect(presenter.final_feedback_questionnaire_link)
      end

      describe "when the final questionnaire has been answered" do
        before do
          complete_final_feedback_questionnaire(participant)
        end

        it "does not return a link to the final feedback questionnaire" do
          expect(presenter.final_feedback_questionnaire_link)
            .to be_nil
        end
      end
    end
  end

  describe "#final_report_card_link" do
    describe "when final questionnaire has not been completed" do
      it "does not return a link to the final report card" do
        expect(presenter.final_report_card_link)
          .to be_nil
      end
    end

    describe "when final questionnaire has been completed" do
      before do
        complete_final_feedback_questionnaire(participant)
      end

      it "returns a link to the final report card" do
        expect(view_context)
          .to receive(:link_to)
          .with(
            "Final Assessment Report Card",
            "/final_report_card",
            class: "list-group-item list-group-item-action"
          )

        expect(presenter.final_report_card_link)
      end

      describe "when final report card has been answered"
    end
  end
end

def complete_cases(participant, klass)
  klass.all.each do |assessment_case|
    create :assessment_question_response,
           assessment_case: assessment_case,
           participant: participant
  end
end

def complete_final_feedback_questionnaire(participant)
  feedback_question =
    create :feedback_question,
           type: FinalFeedbackQuestion
  create :feedback_question_response,
         participant: participant,
         feedback_question: feedback_question
end

def complete_modules(participant)
  (1..HomesPresenter::MODULE_COUNT).each do
    create :story_event, participant: participant
  end
end
