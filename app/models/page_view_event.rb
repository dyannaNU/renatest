# frozen_string_literal: true

# view events created by participants when viewing specific pages
class PageViewEvent < ApplicationRecord
  belongs_to :participant

  validates :participant, :type, presence: true
end
