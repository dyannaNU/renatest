# frozen_string_literal: true

module Pages
  class Assessment < Page
    def has_heading?
      has_css?("h1", text: "Assessment")
    end

    def has_case_title?(title)
      has_css?("h2", text: title)
    end

    def download_case_file
      click_on "Download Case Information"
    end

    def fill_in_responses
      all("select").each do |select|
        select.find("option:last-child").select_option
      end
    end

    def click_save
      click_on "Save & Next"
    end

    def click_save_and_exit
      click_on "Save & Exit"
    end
  end
end
