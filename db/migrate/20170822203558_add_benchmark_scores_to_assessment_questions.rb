class AddBenchmarkScoresToAssessmentQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :assessment_questions, :trainee_benchmark, :integer
    remove_column :assessment_questions, :unsupervised_benchmark, :integer
    remove_column :assessment_questions, :master_benchmark, :integer
  end
end
