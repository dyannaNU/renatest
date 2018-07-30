class CreateConsents < ActiveRecord::Migration[5.1]
  def change
    create_table :consents do |t|
      t.references :participant, foreign_key: true, null: false
      t.boolean :response, null: false

      t.timestamps
    end
  end
end
