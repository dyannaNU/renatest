# frozen_string_literal: true

module DeviseMailHelpers
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def clear_emails
    ActionMailer::Base.deliveries.clear
  end

  def extract_confirmation_path_from_email
    mail_body = last_email.to_s
    mail_body[%r{\/participants\/confirmation\?confirmation_token=\S+}]
  end

  def extract_reset_password_path_from_email
    mail_body = last_email.to_s
    mail_body[%r{\/participants\/password\/edit\?reset_password_token=\S+}]
  end
end
