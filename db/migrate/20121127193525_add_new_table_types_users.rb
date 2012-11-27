class AddNewTableTypesUsers < ActiveRecord::Migration
  def up
  	create_table :types_users, :id => false do |t|
  		t.references :type
  		t.references :user 
  	end
  end

  def down
  	drop_table :types_users
  end
end
