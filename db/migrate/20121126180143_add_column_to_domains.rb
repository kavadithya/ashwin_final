class AddColumnToDomains < ActiveRecord::Migration
  def change
  	add_column :domains, :theowner, :user
  end
end
