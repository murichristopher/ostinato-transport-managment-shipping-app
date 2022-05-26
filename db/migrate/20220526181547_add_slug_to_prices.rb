class AddSlugToPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :slug, :string
    add_index :prices, :slug, unique: true
  end
end
