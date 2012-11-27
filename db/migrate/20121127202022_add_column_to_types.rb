class AddColumnToTypes < ActiveRecord::Migration
  def change
  	add_column :types, :domain_id, :integer
  end
end
