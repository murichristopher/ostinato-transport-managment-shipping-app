class AddSlugToWorkOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :work_orders, :slug, :string
    add_index :work_orders, :slug, unique: true
  end
end
