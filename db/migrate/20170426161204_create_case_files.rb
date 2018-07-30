class CreateCaseFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :case_files do |t|
      t.references :assessment_case, foreign_key: true, null: false
      t.string :title
      t.string :description
      t.attachment :asset, null: false

      t.timestamps
    end
  end
end
