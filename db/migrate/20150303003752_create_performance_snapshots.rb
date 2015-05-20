class CreatePerformanceSnapshots < ActiveRecord::Migration
  def change
    create_table :performance_snapshots do |t|
      t.integer :first_byte
      t.integer :first_paint
      t.integer :render
      t.integer :load_time
      t.integer :full_load_time
      t.integer :total_bytes
      t.integer :requests
      t.text :url

      t.timestamps null: false
    end
  end
end
