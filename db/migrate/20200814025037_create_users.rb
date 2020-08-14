class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false
      t.boolean :manager, default: false
      t.string :activation_digest
      t.datetime :activated_at
      t.boolean :activated, default: false
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.references :warehouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
