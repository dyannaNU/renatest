# frozen_string_literal: true

# responses to the consent form for participants
class Consent < ApplicationRecord
  belongs_to :participant

  validates :participant, :response, presence: true
end
