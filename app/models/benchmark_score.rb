# frozen_string_literal: true

# store benchmark scores
class BenchmarkScore < ApplicationRecord
  validates :percentage, :training_status_id, :skill_id, presence: true
  validates :training_status_id, uniqueness: { scope: :skill_id }

  belongs_to :training_status
  belongs_to :skill

  def self.percentage_for_training_status(training_status)
    find_by(training_status: training_status)
      &.percentage || 0
  end
end
