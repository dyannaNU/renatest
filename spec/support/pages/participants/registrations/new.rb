# frozen_string_literal: true

module Pages
  module Participants
    module Registrations
      class New < Page
        def load
          visit new_participant_session_path
        end

        def click_forgotten_password_link
          click_on "Forgot your password?"

          self
        end

        def click_sign_in
          click_on "Sign up"

          self
        end

        def concede
          click_on "Next"

          self
        end

        def fill_in_forgot_password(email = nil)
          fill_in "Email", with: (email || "foo@ex.co")
          click_on "Send me reset password instructions"

          self
        end

        def fill_in_form(options = {})
          fill_in "Access token", with: options[:token]
          fill_in "Email", with: options[:email] || "foo@ex.co"
          fill_in "Password", with: "secrets!"
          fill_in "Password confirmation", with: "secrets!"
          fill_in "First name", with: options[:first_name] || "Foo"
          fill_in "Last name", with: options[:last_name] || "Bar"
          fill_in "Affiliation", with: options[:affiliation] || "Important"
          select "Trainee", from: "Are you using EMC2 to assess "\
                                  "your proficiency as a:"

          self
        end

        def log_out
          click_on "Logout"

          self
        end

        def update_password
          fill_in "New password", with: "secrets!"
          fill_in "Confirm new password", with: "secrets!"
          click_on "Change my password"

          self
        end
      end
    end
  end
end
