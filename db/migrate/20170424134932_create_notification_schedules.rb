class CreateNotificationSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_schedules do |t|
      t.integer :number_of_days, null: false

      t.timestamps
    end
  end
end
