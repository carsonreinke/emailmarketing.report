class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.text :message
      t.belongs_to :site, {:index => true, :foreign_key => true, :null => false}

      t.timestamps
    end
  end
end
