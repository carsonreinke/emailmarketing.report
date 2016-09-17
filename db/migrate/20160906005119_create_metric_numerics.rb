class CreateMetricNumerics < ActiveRecord::Migration[5.0]
  def change
    create_table :metric_numerics do |t|
      t.decimal :value

      t.timestamps
    end
  end
end
