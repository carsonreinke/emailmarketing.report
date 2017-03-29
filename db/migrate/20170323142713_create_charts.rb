class CreateCharts < ActiveRecord::Migration[5.0]
  def change
    create_table :charts do |t|
      t.string :key
      t.text :configuration

      t.timestamps
    end
    add_index :charts, :key, unique: true
  end
end
