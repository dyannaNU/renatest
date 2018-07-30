# frozen_string_literal: true

module Pages
  class Introduction < Page
    def start_baseline_assessment
      click_on "Begin Baseline Assessment"
    end

    def start_final_assessment
      click_on "Begin Final Assessment"
    end
  end
end
