class CreateModuleFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :module_files do |t|
      t.string :title, null: false
      t.string :description
      t.attachment :asset, null: false

      t.timestamps
    end
  end
end
