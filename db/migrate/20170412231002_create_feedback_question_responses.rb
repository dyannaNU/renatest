class CreateFeedbackQuestionResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :feedback_question_responses do |t|
      t.references :participant, foreign_key: true, null: false
      t.references :feedback_question, foreign_key: true, null: false
      t.string :response_choice, null: false

      t.timestamps
    end
  end
end
