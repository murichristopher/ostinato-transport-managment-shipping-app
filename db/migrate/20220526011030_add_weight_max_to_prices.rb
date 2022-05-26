class AddWeightMaxToPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :weight_max, :decimal
  end
end
