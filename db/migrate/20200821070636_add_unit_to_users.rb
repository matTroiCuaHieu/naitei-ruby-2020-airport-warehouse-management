class AddUnitToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :unit, foreign_key: true
  end
end
