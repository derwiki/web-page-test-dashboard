class AddVisualCompleteToPerformanceSnapshots < ActiveRecord::Migration
  def change
    add_column :performance_snapshots, :visual_complete, :integer
  end
end
