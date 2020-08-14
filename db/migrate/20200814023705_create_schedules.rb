class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.datetime :time
      t.text :reason
      t.references :location, null: false, foreign_key: true
      t.references :plane, null: false, foreign_key: true

      t.timestamps
    end
  end
end
