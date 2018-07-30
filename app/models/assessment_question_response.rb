# frozen_string_literal: true

# responses to assessment questions completed by participants
class AssessmentQuestionResponse < ApplicationRecord
  belongs_to :participant
  belongs_to :assessment_case
  belongs_to :assessment_question
  belongs_to :assessment_answer, optional: true

  validates :participant, :assessment_case, :assessment_question, presence: true

  # Returns the correct responses
  scope :correct, (lambda {
    joins(:assessment_answer).merge(AssessmentAnswer.correct)
  })
end
