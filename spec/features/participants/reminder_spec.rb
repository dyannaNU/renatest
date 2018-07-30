# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Reminder" do
  let!(:participant) { create :participant }
  let!(:assessment_question) { create :assessment_question }

  describe "reminders" do
    def setup_data
      create :assessment_case, type: BaselineAssessmentCase.to_s
      create :assessment_case, type: FinalAssessmentCase.to_s
      create :assessment_question_response,
             participant: participant,
             assessment_case: BaselineAssessmentCase.first,
             assessment_question: AssessmentQuestion.first
    end

    scenario "Received correct email on or after day 1" do
      setup_data
      Timecop.travel(Time.zone.local(2017, 9, 12, 9, 0, 0) + 1.day) do
        Tasks::Reminder.send_reminder
        expect(participant.notification_received_recently?).to be true
      end
    end

    scenario "Recieved correct email on or after day 30" do
      setup_data
      Timecop.travel(Time.zone.local(2017, 9, 12, 9, 0, 0) + 31.days) do
        Tasks::Reminder.send_reminder
        expect(participant.notification_received_recently?).to be true
      end
    end

    scenario "Recieved correct email on or after day 60" do
      setup_data
      Timecop.travel(Time.zone.local(2017, 9, 12, 9, 0, 0) + 61.days) do
        Tasks::Reminder.send_reminder
        expect(participant.notification_received_recently?).to be true
      end
    end
  end
end
