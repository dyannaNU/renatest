# frozen_string_literal: true

module Pages
  class Feedback < Page
    def load
      visit feedback_questionnaire_path(type: BaselineFeedbackQuestion.to_s)
    end

    def complete
      BaselineFeedbackQuestion.find_each do |question|
        select question.response_options[0], from: question.description
      end
      click_on "Save"
    end

    def has_heading?
      has_css?("h1", text: "Feedback Questionnaire")
    end
  end
end
