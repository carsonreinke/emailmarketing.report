class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :name, :null => false
      t.string :url, :null => false
      t.string :email_address, :null => false
      t.boolean :verified, :default => false
      
      t.timestamps
      
      t.index :url, :unique => true
      t.index :email_address, :unique => true
    end
  end
end
