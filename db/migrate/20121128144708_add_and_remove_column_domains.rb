class AddAndRemoveColumnDomains < ActiveRecord::Migration
  def change
  	#remove_column :users, :ownerid, :integer
  	remove_column :domains, :owner, :string
  	add_column :domains, :ownerid, :integer
  end
end
