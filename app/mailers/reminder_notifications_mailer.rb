# frozen_string_literal: true

# sends email to participants
class ReminderNotificationsMailer < ApplicationMailer
  REMINDER_SUBJECT = "Reminder to use EMC2"

  def reminder_notification(participant:)
    @url = home_url
    @first_name = participant.first_name
    @last_name = participant.last_name
    mail(to: participant.email, subject: REMINDER_SUBJECT)
  end
end
