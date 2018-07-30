class AddTimezoneToParticipant < ActiveRecord::Migration[5.1]
  def change
    add_column :participants, :timezone, :string, null: false, default: "Central Time (US & Canada)"
  end
end
