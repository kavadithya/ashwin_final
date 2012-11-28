class CreateTableElementsTypes < ActiveRecord::Migration
  def up
  	create_table :elements_types, :id => false do |t|
  		t.references :element
  		t.references :type 
  	end
  end

  def down
  	drop_table :elements_types
  end

end
