# frozen_string_literal: true

# store skills
class Skill < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_one :assessment_question
  has_many :benchmark_scores
end
