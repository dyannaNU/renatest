# frozen_string_literal: true

# Token sent to participants in order to allow them to participate
class AccessToken < ApplicationRecord
  validates :token, presence: true
end
