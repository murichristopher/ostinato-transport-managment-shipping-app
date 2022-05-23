class TransportCompany < ApplicationRecord
  validates :trading_name, :company_name, :domain, :registration_number, :full_address, presence: true
  validates :trading_name, :company_name, :domain, :registration_number, uniqueness:true
  validates :registration_number, format: { with: /\A[0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2}\z/
  }
  validates :domain, length: {maximum: 30}, format: { with: /\S+\S+\.\S+/ }

end
