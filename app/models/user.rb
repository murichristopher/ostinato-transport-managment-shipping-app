class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :transport_company, optional: true


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { guest: 0, linked: 1 }

  before_validation :set_transport_company


  private

  def set_transport_company
    @user_domain = self.email.match(/(?<=@)(\S+)/).to_s
    @transport_company = TransportCompany.find_by(domain: @user_domain)

    if @transport_company.nil?
      self.user_type = 0
    else
      self.transport_company = @transport_company
      self.user_type = 1
    end
  end

end
