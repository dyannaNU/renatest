# frozen_string_literal: true

# files uploaded by user, downloaded by participant during assessments
class CaseFile < ApplicationRecord
  belongs_to :assessment_case

  # We expect a proprietary type of binary file with extension .mva, so there's
  # no good way to validate it.
  has_attached_file :asset, validate_media_type: false

  validates :assessment_case, :asset, presence: true
  validates :assessment_case, uniqueness: true
  validates_attachment_file_name :asset, matches: [/mva\Z/]
end
