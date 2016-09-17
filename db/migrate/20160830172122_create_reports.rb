class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.belongs_to :email, {:index => true, :foreign_key => true, :null => false}
      t.belongs_to :metric, {:index => true, :null => false, :polymorphic => true}
      t.string :key, :null => false

      t.timestamps

      t.index :key
    end
  end
end
