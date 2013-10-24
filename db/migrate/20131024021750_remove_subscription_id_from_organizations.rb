class RemoveSubscriptionIdFromOrganizations < ActiveRecord::Migration
  def up
    remove_column :organizations, :subscription_id
  end

  def down
    add_column :organizations, :subscription_id, :integer
  end
end
