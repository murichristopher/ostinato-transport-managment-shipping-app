class RenameWeightToWeightMaxInPrices < ActiveRecord::Migration[7.0]
  def change
    rename_column :prices, :weight, :weight_min
  end
end
