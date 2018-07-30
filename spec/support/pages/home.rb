# frozen_string_literal: true

module Pages
  class Home < Page
    def load
      visit home_path
    end

    def has_heading?
      has_css?("h1", text: "Welcome")
    end

    def nav_count
      all(".list-group-item-action").count
    end

    def go_to_how_to
      click_on "Instructions and Overview"
    end

    def go_to_assessment
      click_on "Baseline Assessment"
    end

    def go_to_feedback
      click_on "User Feedback Questionnaire"
    end

    def click_modules
      click_on "Modules"
    end
  end
end
