class AddOrganizationIdIndexToNotifications < ActiveRecord::Migration
  def change
    add_index :notifications, :organization_id
  end
end
