class CreateMetricHistograms < ActiveRecord::Migration[5.0]
  def change
    create_table :metric_histograms do |t|

      t.timestamps
    end
  end
end
