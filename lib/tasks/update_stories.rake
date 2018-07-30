# frozen_string_literal: true

# rubocop:disable Metrics/LineLength
namespace :stories do
  desc "Updates JS files from the client with the correct js code"
  task update_js: :environment do
    system "sed -i .original 's/Script1();/window.opener.postMessage({ story_event: true, id: strId }, window.location.origin);/g' public/*/story_content/user.js"
  end

  desc "Removes the original files"
  task remove_outdated_files: :environment do
    system "rm -rf public/*/story_content/user.js.original"
  end
end
# rubocop:enable Metrics/LineLength
