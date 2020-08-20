class AddUseToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :accept, :boolean
    add_column :schedules, :processing, :boolean, :default => true
    add_reference :schedules, :user, foreign_key: true
  end
end
