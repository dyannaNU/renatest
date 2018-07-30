# frozen_string_literal: true

namespace :fonts do
  desc "Copy font-awesome fonts to `public/assets/` directory"
  task copy_to_assets: :environment do
    system("cp -a public/assets/font-awesome/. public/assets/")
  end
end
