# frozen_string_literal: true

module Pages
  class ConsentForm < Page
    def load
      visit new_consent_path
    end

    def has_heading?
      has_css?("h1", text: "Consent")
    end

    def consent
      click_on "Next"
    end
  end
end
