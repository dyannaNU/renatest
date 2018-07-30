# frozen_string_literal: true

namespace :notifications do
  desc "Send reminder notifications"
  task send_reminder: :environment do
    Tasks::Reminder.send_reminder
  end
end
