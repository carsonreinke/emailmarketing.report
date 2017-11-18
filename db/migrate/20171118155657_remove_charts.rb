class RemoveCharts < ActiveRecord::Migration[5.0]
  def up
    drop_table(:charts, {:if_exists => true})
  end

  def down
    #No-op
  end
end
