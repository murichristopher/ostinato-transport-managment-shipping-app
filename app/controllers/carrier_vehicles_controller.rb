class CarrierVehiclesController < ApplicationController
  before_action :authenticate_linked_user

  def index
    @carrier_vehicles = current_user.transport_company.carrier_vehicles
    @transport_company = current_user.transport_company.trading_name
  end

  def show
    @carrier_vehicle = CarrierVehicle.find(params[:id])

    if @carrier_vehicle.transport_company != current_user.transport_company
      redirect_to root_path, notice:"Você não deveria estar aqui"
    end
  end

  def new
    @carrier_vehicle = CarrierVehicle.new
  end

  def create

    @carrier_vehicle = CarrierVehicle.new(carrier_vehicle_params)

    @carrier_vehicle.transport_company = current_user.transport_company

   if @carrier_vehicle.save
      redirect_to(@carrier_vehicle, notice:"Veículo cadastrada com sucesso!")
    else
      @errors = @carrier_vehicle.errors.full_messages
      render :new
    end
  end

  private

  def authenticate_linked_user
    return redirect_to root_path if current_user.guest?
  end

  def carrier_vehicle_params
    params.require(:carrier_vehicle).permit(:license_plate, :brand, :model, :year, :maximum_load_capacity)
  end

end
