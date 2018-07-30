# frozen_string_literal: true

# The database reference to a Module Story
# Every time a new module story is added from the client a
# new story must be added or updated so the identifiers match
class Story < ApplicationRecord
  validates :file_name,
            :identifier,
            :skill_id, presence: true

  has_many :story_events, dependent: :destroy
  belongs_to :skill
  has_many :benchmark_scores, through: :skill
  has_one :assessment_question, through: :skill

  delegate :title, to: :skill, allow_nil: true

  def benchmark_percentage_for_training_status(training_status)
    benchmark_scores.percentage_for_training_status(training_status)
  end
end
