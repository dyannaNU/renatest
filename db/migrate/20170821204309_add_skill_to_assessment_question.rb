class AddSkillToAssessmentQuestion < ActiveRecord::Migration[5.1]
  def change
    Skill.create!( title: "Pressure Inversion Point" )
    Skill.create!( title: "Hiatal Hernia" )
    Skill.create!( title: "Integrated Relaxation Pressure" )
    Skill.create!( title: "Distal Contractile Integral" )
    Skill.create!( title: "Distal Latency" )
    Skill.create!( title: "Peristaltic Integrity" )
    Skill.create!( title: "Pressurization Pattern" )
    Skill.create!( title: "Esophageal Motility Diagnosis" )

    rename_column :assessment_questions, :skill, :skill_old
    add_reference :assessment_questions, :skill, foreign_key: true
    AssessmentQuestion.reset_column_information

    AssessmentQuestion.find_each do |aq|
      aq.update!(
        skill: Skill.find_by(title: aq.skill_old)
      )
    end

    remove_column :assessment_questions, :skill_old, :string
    change_column_null :assessment_questions, :skill_id, false
  end
end
