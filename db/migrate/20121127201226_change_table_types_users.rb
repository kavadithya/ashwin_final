class ChangeTableTypesUsers < ActiveRecord::Migration
  def change
  	remove_column :types_users, :created_at
  	remove_column :types_users, :updated_at
  end
end
