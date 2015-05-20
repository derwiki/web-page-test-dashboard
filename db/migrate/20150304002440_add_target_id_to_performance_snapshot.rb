class AddTargetIdToPerformanceSnapshot < ActiveRecord::Migration
  def change
    add_column :performance_snapshots, :target_id, :integer
  end
end
