# frozen_string_literal: true

module Devise
  # Stub Devise mailer previews for browser testing.
  class MailerPreview < ActionMailer::Preview
    def user_confirmation_instructions
      Devise::Mailer.confirmation_instructions(User.first, "abcde")
    end

    def user_reset_password_instructions
      Devise::Mailer.reset_password_instructions(User.first, "abcde")
    end

    def user_unlock_instructions
      Devise::Mailer.unlock_instructions(User.first, "abcde")
    end

    def user_password_change
      Devise::Mailer.password_change(User.first)
    end
  end
end
