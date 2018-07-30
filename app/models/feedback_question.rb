# frozen_string_literal: true

# questions posed to the participants before baseline assessment and
# after final assessment
class FeedbackQuestion < ApplicationRecord
  QUESTION_TYPES = %w[BaselineFeedbackQuestion FinalFeedbackQuestion].freeze

  has_many :feedback_question_responses, dependent: :restrict_with_error

  validates :description, :response_options, presence: true
  validates :type, inclusion: { in: QUESTION_TYPES }
end
