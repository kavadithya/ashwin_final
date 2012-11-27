class CreateTableDomains < ActiveRecord::Migration
  def up
  	create_table :domains do |t|
      t.string :name
      t.string :owner

      t.timestamps
    end
  end

  def down
  	drop_table :domains
  end
end
