class AddSkillToStory < ActiveRecord::Migration[5.1]
  def change
    rename_column :stories, :title, :title_old
    add_reference :stories, :skill, foreign_key: true
    Story.reset_column_information
    Story.find_each do |story|
      story.update!(
        skill: Skill.find_by(title: story.title_old)
      )
    end
    remove_column :stories, :title_old, :string
    change_column_null :stories, :skill_id, false
  end
end
