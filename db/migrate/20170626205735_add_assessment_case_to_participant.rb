class AddAssessmentCaseToParticipant < ActiveRecord::Migration[5.1]
  def change
    add_reference :participants, :assessment_case, foreign_key: true, nil: true, index: true
  end
end
