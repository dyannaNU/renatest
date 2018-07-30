# frozen_string_literal: true

module Pages
  class HowToGuide < Page
    def has_heading?
      has_css?("h1", text: "Instructions and Overview")
    end
  end
end
