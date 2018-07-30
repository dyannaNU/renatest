# frozen_string_literal: true

# Mailer superclass.
class ApplicationMailer < ActionMailer::Base
  DEFAULT_FROM = "esophageal.quality@gmail.com"
  default from: DEFAULT_FROM
  layout "mailer"
end
