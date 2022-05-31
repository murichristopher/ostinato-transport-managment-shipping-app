class AddPriceToMinimalPrice < ActiveRecord::Migration[7.0]
  def change
    add_column :minimal_prices, :price, :decimal
  end
end
