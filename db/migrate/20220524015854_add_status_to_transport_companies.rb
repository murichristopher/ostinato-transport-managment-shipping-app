class AddStatusToTransportCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :transport_companies, :status, :integer, default:5
  end
end
