class CreateMetricSets < ActiveRecord::Migration[5.0]
  def change
    create_table :metric_sets do |t|

      t.timestamps
    end
  end
end
