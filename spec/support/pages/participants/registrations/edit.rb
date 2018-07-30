# frozen_string_literal: true

module Pages
  module Participants
    module Registrations
      class Edit < Page
        def load
          visit edit_participant_registration_path
        end

        def fill_in_form(options = {})
          fill_in "Current password", with: options[:password] || "secrets!"
          fill_in "First name", with: options[:first_name] || "Foo"
          fill_in "Last name", with: options[:last_name] || "Bar"
          fill_in "Affiliation", with: options[:affiliation] || "Important"
          select options[:training_status], from: "Are you using EMC2 to " \
                                                  "assess your proficiency as" \
                                                  " a:"
        end

        def submit
          click_on "Update"
        end
      end
    end
  end
end
