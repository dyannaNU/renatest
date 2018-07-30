class UpdateAssessmentQuestionResponseResponseChoiceToAllowNull < ActiveRecord::Migration[5.1]
  def change
    change_column :assessment_question_responses, :response_choice, :string, null: true
  end
end
