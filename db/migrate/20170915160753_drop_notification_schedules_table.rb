class DropNotificationSchedulesTable < ActiveRecord::Migration[5.1]
  def change
  	drop_table :notification_schedules, force: :cascade
  end
end
