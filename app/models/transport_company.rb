class TransportCompany < ApplicationRecord
  extend FriendlyId
  friendly_id :company_name, use: :slugged

  has_many :users
  has_many :carrier_vehicles
  has_many :prices
  #TransportCompany.last.users => search all users of a target transportcompany
  enum status: { inactive: 0, active: 5 }

  validates :trading_name, :company_name, :domain, :registration_number, :full_address, presence: true
  validates :trading_name, :company_name, :domain, :registration_number, uniqueness:true
  validates :registration_number, format: { with: /\A[0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2}\z/
  }
  validates :domain, length: {maximum: 30}, format: { with: /\S+\S+\.\S+/ }

end
