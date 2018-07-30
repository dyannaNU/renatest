# frozen_string_literal: true

# questions that are asked for each assessment case, completed by participants
class AssessmentQuestion < ApplicationRecord
  validates :position, :skill, :description, presence: true
  validates :position, uniqueness: true

  has_many :assessment_answers, dependent: :destroy
  has_many :assessment_question_responses, dependent: :restrict_with_error
  belongs_to :skill

  def assessment_answers_for_case(assessment_case)
    assessment_answers.where(assessment_case: assessment_case)
  end
end
