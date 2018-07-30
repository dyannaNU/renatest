class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string :file_name, null: false
      t.string :identifier, null: false
      t.string :title, null: false

      t.timestamps
    end

    remove_column :story_events, :story_identifier
    add_reference :story_events, :story, index: true, null: false
  end
end
