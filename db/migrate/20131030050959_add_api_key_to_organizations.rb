class AddApiKeyToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :api_key, :string
  end
end
