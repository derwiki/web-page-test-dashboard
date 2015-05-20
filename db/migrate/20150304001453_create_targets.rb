class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :label
      t.text :script

      t.timestamps null: false
    end
  end
end
