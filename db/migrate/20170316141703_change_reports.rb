class ChangeReports < ActiveRecord::Migration[5.0]
  def up
    Report.delete_all()

    change_table :reports do |t|
      t.remove_belongs_to :metric, {:polymorphic => true}

      t.string :type
      t.integer :integer
      t.string :string
      t.decimal :decimal
    end
  end

  def down
    Report.delete_all()
    
    change_table :reports do |t|
      t.belongs_to :metric, {:index => true, :polymorphic => true}
      t.remove :type, :integer, :string, :decimal
    end
  end
end
