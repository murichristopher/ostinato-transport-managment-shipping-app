class WorkOrder < ApplicationRecord
  belongs_to :transport_company
  belongs_to :carrier_vehicle, optional: true

  before_create :calc_delivery_time
  before_create :calc_total_price
  before_create :generate_unique_code

  enum status: { pending: 1, accepted: 2, refused: 3, on_carriage: 4, received: 5}

  validates :sender_address, :receiver_address, :receiver_name, :receiver_cpf , :cubic_size, :total_weight, :total_distance,  presence: true

  validates :cubic_size, :total_weight,  :total_distance, numericality: { greater_than: 0 }
  validates :receiver_cpf, length: { is: 11 }


  #custom validations
  validate :check_transport_company

  private

  def calc_delivery_time
    delivery_time = get_delivery_time()

    if delivery_time.empty?
      self.delivery_time = nil
    else
      self.delivery_time = delivery_time.last.time
    end
  end

  def check_transport_company
    return nil if transport_company.nil?

    if get_price().empty?
      errors.add :transport_company, "não possui preços cadastrados com esses requisitos"
    end
  end

  def generate_unique_code
    self.unique_code = "##{SecureRandom.alphanumeric(10).upcase}"
  end

  def get_price
    Price.where(transport_company: transport_company_id).where("cubic_meters_min <= ? AND cubic_meters_max >= ? AND weight_min <= ? AND weight_max >= ?", cubic_size, cubic_size, total_weight, total_weight)
  end

  def get_delivery_time
    DeliveryTime.where(transport_company: transport_company_id).where("km_min <= ? AND km_max >= ?", total_distance, total_distance)
  end

  def calc_total_price
    self.total_price = total_distance * get_price().last.value_per_km
  end



end


