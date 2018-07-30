# frozen_string_literal: true

require "rails_helper"

RSpec.describe Participant, type: :model do
  let(:participant) { create :participant }
  let(:participant2) { create :participant }
  let(:participant3) { create :participant }

  before do
    AssessmentCase.destroy_all
    create :assessment_case, type: BaselineAssessmentCase.to_s
    create :assessment_case, type: FinalAssessmentCase.to_s
  end

  describe "validations" do
    it { expect(participant).to be_valid }

    describe "is invalid with no email" do
      before { participant.email = nil }

      it { expect(participant).to_not be_valid }
    end

    describe "is invalid with no first_name" do
      before { participant.first_name = nil }

      it { expect(participant).to_not be_valid }
    end

    describe "is invalid with no last_name" do
      before { participant.last_name = nil }

      it { expect(participant).to_not be_valid }
    end

    describe "is invalid with no affiliation" do
      before { participant.affiliation = nil }

      it { expect(participant).to_not be_valid }
    end

    describe "is invalid with no training_status" do
      before { participant.training_status = nil }

      it { expect(participant).to_not be_valid }
    end

    describe "is invalid with no timezone" do
      before { participant.timezone = nil }

      it { expect(participant).to_not be_valid }
    end
  end

  describe ".receives_notification" do
    let!(:assessment_question) { create :assessment_question }
    before do
      Timecop.travel(Time.zone.local(2017, 9, 3, 9, 0, 0))
      create :sent_notification,
             participant: participant2,
             created_at: 1.day.ago
      create :assessment_question_response,
             participant: participant,
             assessment_case: BaselineAssessmentCase.first,
             assessment_question: AssessmentQuestion.first
      create :assessment_question_response,
             participant: participant2,
             assessment_case: BaselineAssessmentCase.first,
             assessment_question: AssessmentQuestion.first
      create :assessment_question_response,
             participant: participant3,
             assessment_case: BaselineAssessmentCase.first,
             assessment_question: AssessmentQuestion.first
      create :assessment_question_response,
             participant: participant3,
             assessment_case: FinalAssessmentCase.last,
             assessment_question: AssessmentQuestion.first
    end

    after { Timecop.return }

    it "includes participant who has started baseline" do
      expect(Participant.receives_notification).to include participant
    end

    it "does not include participant who has received notification recently" do
      expect(Participant.receives_notification).to_not include participant2
    end

    it "does not include participant who has completed final case" do
      expect(Participant.receives_notification).to_not include participant3
    end
  end

  describe ".within_notification_time_range?" do
    context "when within range" do
      before { Timecop.travel(Time.zone.local(2017, 9, 3, 9, 0, 0)) }
      after { Timecop.return }

      it "returns true" do
        expect(
          Participant.within_notification_time_range?(Time.zone, Time.zone.now)
        ).to eq true
      end
    end

    context "when not within range" do
      before { Timecop.travel(Time.zone.local(2017, 9, 3, 9, 15, 0)) }
      after { Timecop.return }

      it "returns false" do
        expect(
          Participant.within_notification_time_range?(Time.zone, Time.zone.now)
        ).to eq false
      end
    end
  end

  describe ".receives_notification" do
    describe "when no notifications have been scheduled" do
      it "returns an empty array" do
        expect(Participant.receives_notification)
          .to be_empty
      end
    end
  end

  describe "#notification_received_recently?" do
    describe "when the participant has no sent_notifications" do
      it { expect(participant.notification_received_recently?).to eq false }
    end

    describe "when the participant has received a notification " \
             "within the Notification Schedule time period" do
      before do
        create :sent_notification,
               participant: participant,
               created_at: 12.days.ago
      end

      it { expect(participant.notification_received_recently?).to eq true }
    end

    describe "when the participant has received a notification within the" \
             " NotificationSchedule time period" do
      before do
        create :sent_notification,
               participant: participant,
               created_at: 1.day.ago
      end

      it { expect(participant.notification_received_recently?).to eq true }
    end

    describe "when no notification schedules exist" do
      before do
        create :sent_notification,
               participant: participant,
               created_at: 12.days.ago
      end

      it { expect(participant.notification_received_recently?).to eq true }
    end
  end

  describe "#active?" do
    let!(:assessment_question) { create :assessment_question }
    before do
      create :assessment_question_response,
             participant: participant,
             assessment_case: BaselineAssessmentCase.first,
             assessment_question: AssessmentQuestion.first
      create :assessment_question_response,
             participant: participant3,
             assessment_case: BaselineAssessmentCase.first,
             assessment_question: AssessmentQuestion.first
      create :assessment_question_response,
             participant: participant3,
             assessment_case: FinalAssessmentCase.last,
             assessment_question: AssessmentQuestion.first
      participant.update(assessment_case: FinalAssessmentCase.first)
    end

    context "when participant has started baseline but not completed final" do
      it { expect(participant.active?).to eq true }
    end

    context "when participant has started baseline and completed final" do
      it { expect(participant3.active?).to eq false }
    end
  end

  describe "#completed_assessment_case?" do
    before do
      create :assessment_question_response,
             participant: participant,
             assessment_case: BaselineAssessmentCase.first
    end

    context "when participant has started an assessment" do
      before do
        participant.update(assessment_case: BaselineAssessmentCase.first)
      end

      it "returns false" do
        expect(participant.completed_assessment_case?(BaselineAssessmentCase))
          .to eq false
      end
    end

    context "when participant has completed an assessment" do
      before do
        participant.update(assessment_case: nil)
      end

      it "returns true" do
        expect(participant.completed_assessment_case?(BaselineAssessmentCase))
          .to eq true
      end
    end
  end
end
