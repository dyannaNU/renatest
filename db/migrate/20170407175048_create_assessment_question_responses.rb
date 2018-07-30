class CreateAssessmentQuestionResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :assessment_question_responses do |t|
      t.references :participant, foreign_key: true, null: false
      t.references :assessment_case, foreign_key: true, null: false
      t.references :assessment_question, foreign_key: true, null: false
      t.string :response_choice, null: false

      t.timestamps
    end
  end
end
