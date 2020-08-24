class ChangeSchedulesToRequests < ActiveRecord::Migration[6.0]
  def change
    rename_table :schedules, :requests
  end
end
