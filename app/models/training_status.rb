# frozen_string_literal: true

# store training statuses
class TrainingStatus < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
