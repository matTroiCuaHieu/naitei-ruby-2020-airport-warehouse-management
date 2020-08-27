class AddDenyreasonToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :deny_reason, :string
    add_column :requests, :approver, :bigint
  end
end
