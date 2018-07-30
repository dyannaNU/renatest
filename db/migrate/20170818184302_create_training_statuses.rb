class CreateTrainingStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :training_statuses do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
