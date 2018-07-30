# frozen_string_literal: true

# files uploaded by user, downloaded by participant to supplement module content
class ModuleFile < ApplicationRecord
  FILE_PATH = Rails
              .root
              .join("public", "system", "module_files", "emc2", ":title.mva")
              .to_s

  # We expect a proprietary type of binary file with extension .mva, so there's
  # no good way to validate it.
  has_attached_file :asset, path: FILE_PATH, validate_media_type: false

  validates_attachment_file_name :asset, matches: [/mva\Z/]
  validates :asset, :title, presence: true
  validates :title, uniqueness: true

  Paperclip.interpolates :title do |attachment, _style|
    attachment.instance.title.downcase.tr(" ", "_")
  end
end
