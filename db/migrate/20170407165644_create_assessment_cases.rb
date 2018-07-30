class CreateAssessmentCases < ActiveRecord::Migration[5.1]
  def change
    create_table :assessment_cases do |t|
      t.integer :position, null: false
      t.text :description, null: false
      t.string :type, null: false

      t.timestamps
    end

    require_relative "../seeds/assessment_cases"
  end
end
