class CreateWarehouses < ActiveRecord::Migration[6.0]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :area
      t.bigint :amount

      t.timestamps
    end
  end
end
