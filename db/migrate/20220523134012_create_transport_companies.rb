class CreateTransportCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :transport_companies do |t|
      t.string :trading_name
      t.string :company_name
      t.string :domain
      t.string :registration_number
      t.string :full_address

      t.timestamps
    end
  end
end
