# frozen_string_literal: true

module Tasks
  # reminder notification to participants to use the app
  class Reminder
    def self.send_reminder
      logger.info "START: notifications:reminder"
      Participant.receives_notification.each do |participant|
        begin
          send_email_for(participant)
        rescue => exception
          notify_raven(participant, exception) if defined?(Raven)
        end
      end
      logger.info "END: notifications:reminder"
    end

    def self.send_email_for(participant)
      participant.sent_notifications.create!
      email = participant.email
      logger.info "send reminder notification to #{email} on #{Time.zone.now}"
      ReminderNotificationsMailer
        .reminder_notification(participant: participant)
        .deliver_now
    end

    def self.logger
      Logger.new(STDOUT)
    end

    def self.notify_raven(participant, exception)
      Raven.extra_context(
        participant_id: participant.try(:id),
        message: exception.message
      )
      Raven.capture_exception exception
    end
  end
end
