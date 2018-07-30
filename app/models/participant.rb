# frozen_string_literal: true

# a user who has access to consent, assessments, and modules
class Participant < ApplicationRecord
  BEGINNING_OF_NOTIFICATION_TIME_RANGE = "8:50am"
  END_OF_NOTIFICATION_TIME_RANGE = "9:10am"
  NOTIFICATION_INTERVAL = 30.days

  attr_accessor :access_token

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  validates :email, :first_name, :last_name, :affiliation, :timezone,
            presence: true

  has_one :consent, dependent: :destroy
  belongs_to :assessment_case, optional: true

  has_many :page_view_events, dependent: :destroy
  has_many :assessment_question_responses, dependent: :destroy
  has_many :baseline_assessment_cases,
           through: :assessment_question_responses,
           source: :assessment_case,
           class_name: BaselineAssessmentCase.to_s
  has_many :final_assessment_cases,
           through: :assessment_question_responses,
           source: :assessment_case,
           class_name: FinalAssessmentCase.to_s
  has_many :feedback_question_responses, dependent: :destroy
  has_many :baseline_feedback_questions,
           through: :feedback_question_responses,
           source: :feedback_question,
           class_name: BaselineFeedbackQuestion.to_s
  has_many :final_feedback_questions,
           through: :feedback_question_responses,
           source: :feedback_question,
           class_name: FinalFeedbackQuestion.to_s
  has_many :sent_notifications, dependent: :restrict_with_error
  has_many :story_events, dependent: :destroy
  has_many :stories, through: :story_events
  belongs_to :training_status

  def any_how_to_event
    page_view_events.find_by(type: HowToViewEvent.to_s)
  end

  def completed_assessment_case?(klass)
    send(klass.to_s.tableize)
      .uniq
      .count >= klass.count &&
      !assessment_case.is_a?(klass)
  end

  def current_case(type)
    send(type.tableize)
      .order(:position)
      .last
      .try(:position)
  end

  def completed_all_questionnaire_items?(type)
    questions = FeedbackQuestion.where(type: type)
    responses = feedback_question_responses.where(feedback_question: questions)
    questions.count == responses.count
  end

  def self.receives_notification
    all.map do |participant|
      Time.use_zone(participant.timezone) do
        time = Time.zone
        now = time.now
        next unless within_notification_time_range?(time, now) &&
                    participant.active?
        next if participant.notification_received_recently?
        participant
      end
    end.reject(&:nil?)
  end

  def self.within_notification_time_range?(time, now)
    now > time.parse(BEGINNING_OF_NOTIFICATION_TIME_RANGE) &&
      now < time.parse(END_OF_NOTIFICATION_TIME_RANGE)
  end

  def notification_received_recently?
    return false if sent_notifications.empty?
    sent_notifications.order(:created_at).last.created_at >
      NOTIFICATION_INTERVAL.ago
  end

  def active?
    !completed_assessment_case?(FinalAssessmentCase)
  end

  def correct_responses_for_question_and_cases(question:, cases:)
    assessment_question_responses
      .where(assessment_question: question, assessment_case: cases)
      .correct
  end

  def story_event_exists?(story)
    story_events.exists?(story: story)
  end
end
