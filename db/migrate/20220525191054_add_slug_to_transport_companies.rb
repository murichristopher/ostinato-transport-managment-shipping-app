class AddSlugToTransportCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :transport_companies, :slug, :string
    add_index :transport_companies, :slug, unique: true
  end
end
