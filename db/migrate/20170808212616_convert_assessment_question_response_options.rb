class ConvertAssessmentQuestionResponseOptions < ActiveRecord::Migration[5.1]
  class AssessmentAnswerMigration < ApplicationRecord
    self.table_name = "assessment_answers"
  end

  def change
    AssessmentQuestion.transaction do
      AssessmentQuestion.find_each do |question|
        question.response_options.each_with_index do |option, index|
          AssessmentAnswerMigration.create!(
            assessment_question_id: question.id,
            position: index + 1,
            title: option
          )
        end
      end
    end

    remove_column :assessment_questions, :response_options, :string, null: false, array: true
  end
end
