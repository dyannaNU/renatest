class AddAssessmentAnswerIdToAssessmentQuestionResponses < ActiveRecord::Migration[5.1]
  def change
    add_reference :assessment_question_responses, :assessment_answer, foreign_key: true

    AssessmentQuestionResponse.reset_column_information
    AssessmentQuestionResponse.find_each do |response|
      response.update(assessment_answer: AssessmentAnswer.find_by(title: response.response_choice))
    end

    remove_column :assessment_question_responses, :response_choice, :string, null: false
  end
end
