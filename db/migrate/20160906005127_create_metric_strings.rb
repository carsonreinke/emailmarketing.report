class CreateMetricStrings < ActiveRecord::Migration[5.0]
  def change
    create_table :metric_strings do |t|

      t.timestamps
    end
  end
end
