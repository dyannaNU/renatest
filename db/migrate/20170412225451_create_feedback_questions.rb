class CreateFeedbackQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :feedback_questions do |t|
      t.string :type, null: false
      t.string :description, null: false
      t.string :response_options, null: false, array: true

      t.timestamps
    end
  end
end
