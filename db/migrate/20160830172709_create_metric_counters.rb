class CreateMetricCounters < ActiveRecord::Migration[5.0]
  def change
    create_table :metric_counters do |t|
      t.integer :value

      t.timestamps
    end
  end
end
