# frozen_string_literal: true

# Records when stories have been completed by a participant
class StoryEvent < ApplicationRecord
  validates :completed_at,
            :participant_id,
            :story_id,
            presence: true

  belongs_to :participant
  belongs_to :story
end
