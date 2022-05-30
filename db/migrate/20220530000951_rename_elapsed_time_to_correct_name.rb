class RenameElapsedTimeToCorrectName < ActiveRecord::Migration[7.0]
  def change
    rename_column :work_order_routes, :elapseelapsed_time, :elapsed_time
  end
end
