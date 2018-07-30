class CreatePageViewEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :page_view_events do |t|
      t.string :type, null: false
      t.references :participant, foreign_key: true, null: false

      t.timestamps
    end
  end
end
