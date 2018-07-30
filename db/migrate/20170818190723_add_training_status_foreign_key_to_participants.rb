class AddTrainingStatusForeignKeyToParticipants < ActiveRecord::Migration[5.1]
  def change
    TrainingStatus.create!( title: "trainee" )
    TrainingStatus.create!( title: "unsupervised practice" )
    TrainingStatus.create!( title: "master" )

    rename_column :participants, :training_status, :training_status_old
    add_reference :participants, :training_status, foreign_key: true
    Participant.reset_column_information

    Participant.find_each do |participant|
      participant.update!(
        training_status: TrainingStatus.find_by(title: participant.training_status_old.downcase)
      )
    end

    remove_column :participants, :training_status_old, :string
    change_column_null :participants, :training_status_id, false
  end
end
