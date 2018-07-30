# frozen_string_literal: true

# Responses by participant to feedback questions
class FeedbackQuestionResponse < ApplicationRecord
  belongs_to :participant
  belongs_to :feedback_question

  validates :participant, :feedback_question, :response_choice, presence: true
end
