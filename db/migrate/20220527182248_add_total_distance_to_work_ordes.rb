class AddTotalDistanceToWorkOrdes < ActiveRecord::Migration[7.0]
  def change
    add_column :work_orders, :total_distance, :integer
  end
end
