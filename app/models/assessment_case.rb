# frozen_string_literal: true

# case studies for assessments completed by participant
# types include Baseline and Final
class AssessmentCase < ApplicationRecord
  validates :position, :description, presence: true
  validates :position, uniqueness: { scope: :type }
  validates :type,
            inclusion: { in: %w[BaselineAssessmentCase FinalAssessmentCase] }

  has_many :assessment_answers, dependent: :destroy
  has_many :assessment_question_responses, dependent: :restrict_with_error
  has_one :case_file, dependent: :nullify

  def questions
    AssessmentQuestion.all
  end
end
