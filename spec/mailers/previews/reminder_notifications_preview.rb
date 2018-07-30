# frozen_string_literal: true

class ReminderNotificationsPreview < ActionMailer::Preview
  def reminder_notification
    ReminderNotificationsMailer.reminder_notification(
      participant: Participant.first
    )
  end
end
