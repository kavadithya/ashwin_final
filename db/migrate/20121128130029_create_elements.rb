class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :name
      t.string :link
      t.integer :domain_id

      t.timestamps
    end
  end
end
