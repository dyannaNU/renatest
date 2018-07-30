class CreateStoryEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :story_events do |t|
      t.references :participant, null: false
      t.datetime :completed_at, null: false
      t.string :story_identifier, null: false

      t.timestamps
    end
  end
end
