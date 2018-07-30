class AddAssessmentCaseReferenceToAssessmentAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :assessment_answers, :assessment_case, foreign_key: true
    AssessmentAnswer.reset_column_information
    AssessmentAnswer.find_each do |answer|
      # associate existing answers with the first case
      answer.update!(assessment_case: AssessmentCase.first)
      # create similar answers for the remaining cases
      AssessmentCase.all[1..-1].each do |assessment_case|
        assessment_case.assessment_answers.create!(
          assessment_question: answer.assessment_question,
          position: answer.position,
          title: answer.title
        )
      end
    end
    change_column_null :assessment_answers, :assessment_case_id, false
  end
end
