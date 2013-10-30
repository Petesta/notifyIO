class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notification_type
      t.text :message
      t.integer :organization_id

      t.timestamps
    end
  end
end
