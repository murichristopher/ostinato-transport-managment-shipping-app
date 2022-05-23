class AddTransportCompanyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :transport_company, null: true, foreign_key: true
  end
end
