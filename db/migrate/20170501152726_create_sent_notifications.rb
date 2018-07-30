class CreateSentNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :sent_notifications do |t|
      t.references :participant, foreign_key: true, null: false

      t.timestamps
    end
  end
end
