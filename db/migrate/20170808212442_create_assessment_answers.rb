class CreateAssessmentAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :assessment_answers do |t|
      t.references :assessment_question, foreign_key: true, null: false
      t.string :position, null: false
      t.string :title, null: false
      t.boolean :is_correct, null: false, default: false

      t.timestamps
    end
  end
end
