# frozen_string_literal: true

# record of sent notifications to participants reminding them to use the app
class SentNotification < ApplicationRecord
  belongs_to :participant

  validates :participant, presence: true
end
