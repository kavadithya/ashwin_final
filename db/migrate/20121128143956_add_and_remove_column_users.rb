class AddAndRemoveColumnUsers < ActiveRecord::Migration
  def change
  	add_column :users, :ownerid, :integer
  	remove_column :users, :owner, :string
  end
end
