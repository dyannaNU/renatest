# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Home" do
  let(:participant) { create :participant }
  let(:home) { Pages::Home.new }
  let(:consent_form) { Pages::ConsentForm.new }
  let(:how_to_guide) { Pages::HowToGuide.new }
  let(:feedback) { Pages::Feedback.new }
  let(:assessment) { Pages::Assessment.new }

  before { sign_in participant }

  describe "when a participant has not completed a consent form" do
    scenario "the participant is immediately redirected to the consent" do
      home.load

      expect(consent_form).to have_heading
    end
  end

  describe "when a participant has completed consent" do
    before { create :consent, participant: participant }

    scenario "the participant can only navigate to the how-to guide" do
      home.load

      expect(home.nav_count).to eq 1

      home.go_to_how_to

      expect(how_to_guide).to have_heading
    end

    describe "when a participant has completed how-to" do
      before do
        create :page_view_event,
               type: "HowToViewEvent",
               participant: participant
        create :feedback_question
      end

      scenario "the participant can only navigate to how-to and feedback" do
        home.load

        expect(home.nav_count).to eq 2

        home.go_to_how_to

        expect(how_to_guide).to have_heading

        home.load
        home.go_to_feedback

        expect(feedback).to have_heading
      end

      describe "the participant has completed feedback" do
        let(:intro) { Pages::Introduction.new }

        before do
          BaselineFeedbackQuestion.find_each do |question|
            create :feedback_question_response,
                   participant: participant,
                   feedback_question: question,
                   response_choice: "foo"
          end
        end

        scenario "the participant can only navigate to how-to and assessment" do
          home.load

          expect(home.nav_count).to eq 2
          expect(page).to have_link "Instructions and Overview"
          expect(page).to have_link "Baseline Assessment"

          home.go_to_how_to

          expect(how_to_guide).to have_heading

          home.load
          home.go_to_assessment
          intro.start_baseline_assessment

          expect(assessment).to have_heading
        end

        describe "when a participant has not started baseline assessment" do
          before do
            create :case_file, assessment_case: AssessmentCase.first
          end

          after { CaseFile.destroy_all }

          scenario "the participant is taken to the first assessment case" do
            home.load
            home.go_to_assessment

            expect(page)
              .to have_text "You will now interpret 10 esophageal HRM cases"\
                " using your locally installed ManoView software."

            intro.start_baseline_assessment

            expect(assessment).to have_case_title("Case 1")

            assessment.download_case_file

            expect(response_headers["Content-Type"]).to eq "text/plain"
          end
        end

        describe "when a participant has started a baseline assessment" do
          let!(:assessment_case) { AssessmentCase.find_by(position: 1) }
          let!(:assessment_question) { create :assessment_question }
          let!(:assessment_answer) do
            create :assessment_answer,
                   assessment_case: assessment_case,
                   assessment_question: assessment_question
          end

          before do
            participant.update(assessment_case: assessment_case)
            AssessmentQuestion.find_each do |assessment_question|
              create :assessment_question_response,
                     participant: participant,
                     assessment_case: assessment_case,
                     assessment_question: assessment_question
            end
          end

          scenario "the participant is taken to that asessment" do
            home.load
            home.go_to_assessment

            expect(assessment).to have_case_title("Case 1")
          end

          describe "when the participant clicks 'Save & Next'" do
            scenario "the participant is taken to next case assessment" do
              home.load
              home.go_to_assessment
              assessment.fill_in_responses
              assessment.click_save

              expect(assessment)
                .to have_case_title("Case 2")
            end
          end

          describe "when the participant clicks 'Save & Exit'", :js do
            scenario "is taken home, then back to the next case assessment" do
              home.load
              home.go_to_assessment
              expect(assessment.has_heading?)
                .to eq true
              assessment.fill_in_responses
              assessment.click_save_and_exit

              expect(home.has_heading?)
                .to eq true

              home.go_to_assessment

              expect(assessment)
                .to have_case_title("Case 2")
            end
          end

          describe "when the participant leaves without finishing a case" do
            scenario "participant is taken to current case upon returning" do
              home.load
              home.go_to_assessment

              expect(assessment).to have_case_title("Case 1")

              home.load
              home.go_to_assessment

              expect(assessment).to have_case_title("Case 1")
            end
          end
        end

        describe "when a participant has completed the baseline assessment" do
          let(:module_index) { Pages::ModuleIndex.new }
          let!(:assessment_case) { AssessmentCase.find_by(position: 1) }
          let!(:assessment_question) { create :assessment_question }
          let!(:assessment_answer) do
            create :assessment_answer,
                   assessment_case: assessment_case,
                   assessment_question: assessment_question
          end

          before do
            BaselineAssessmentCase.find_each do |assessment_case|
              AssessmentQuestion.find_each do |assessment_question|
                create :assessment_question_response,
                       participant: participant,
                       assessment_case: assessment_case,
                       assessment_question: assessment_question
              end
            end
          end

          scenario "can only navigate to how-to, report card, modules" do
            home.load

            expect(home.nav_count).to eq 3
            expect(page).to have_link "Instructions and Overview"
            expect(page).to have_link "Baseline Assessment Report Card"
            expect(page).to have_link "Modules"

            home.go_to_how_to

            expect(how_to_guide).to have_heading
          end

          scenario "can review the baseline report card" do
            home.load

            click_link "Baseline Assessment Report Card"

            expect(page)
              .to have_css "h1", text: "Baseline Assessment Report Card"
          end
        end
      end
    end
  end
end
