class RemoveMetrics < ActiveRecord::Migration[5.0]
  def up
    drop_table :metric_counters
    drop_table :metric_numerics
    drop_table :metric_strings
  end

  def down
    create_table :metric_counters do |t|
      t.integer :value

      t.timestamps
    end
    create_table :metric_numerics do |t|
      t.decimal :value

      t.timestamps
    end
    create_table :metric_strings do |t|
      t.string :value

      t.timestamps
    end
  end
end
