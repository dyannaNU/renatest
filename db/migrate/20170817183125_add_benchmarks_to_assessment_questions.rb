class AddBenchmarksToAssessmentQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :assessment_questions, :trainee_benchmark, :integer
    add_column :assessment_questions, :unsupervised_benchmark, :integer
    add_column :assessment_questions, :master_benchmark, :integer
  end
end
