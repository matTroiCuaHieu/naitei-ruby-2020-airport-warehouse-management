class RemoveAndAddColummApprover < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :approver, :bigint
    add_column :requests, :approver, :string
  end
end
