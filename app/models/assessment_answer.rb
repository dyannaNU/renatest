# frozen_string_literal: true

# Each AssessmentQuestion has multiple available AssessmentAnswers that can
# be chosen by a Participant. The questions are the same for each
# AssessmentCase, but there are different correct answers for each case.
class AssessmentAnswer < ApplicationRecord
  belongs_to :assessment_question
  belongs_to :assessment_case

  has_many :assessment_question_responses, dependent: :restrict_with_error

  validates :assessment_question, :assessment_case, :position, :title,
            presence: true
  validates :is_correct, inclusion: { in: [true, false] }

  scope :correct, (-> { where(is_correct: true) })
end
