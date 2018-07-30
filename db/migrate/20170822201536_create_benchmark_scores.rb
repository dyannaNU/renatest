class CreateBenchmarkScores < ActiveRecord::Migration[5.1]
  def change
    create_table :benchmark_scores do |t|
      t.references :skill, foreign_key: true, null: false
      t.references :training_status, foreign_key: true, null: false
      t.integer :percentage, null: false

      t.timestamps
    end
  end
end
