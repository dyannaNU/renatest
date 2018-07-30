class CreateAssessmentQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :assessment_questions do |t|
      t.integer :position, null: false
      t.string :skill, null: false
      t.string :description, null: false
      t.string :response_options, null: false, array: true

      t.timestamps
    end
  end
end
