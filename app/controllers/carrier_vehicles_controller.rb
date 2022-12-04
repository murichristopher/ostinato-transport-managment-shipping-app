class CarrierVehiclesController < ApplicationController
  before_action :authenticate_linked_user
  before_action :set_carrier_vehicle_and_check_company, only: [:show, :edit, :update, :destroy]

  def index
    @carrier_vehicles = currednt_use3r.transport_company.carrier_vehicles
    @transport_company = current_user.transport_company.trading_name
  end

  def show
    @transport_company = current_user.transport_company.trading_name
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

  def edit
    check_user_company()
  end

  def update
      if @carrier_vehicle.update(carrier_vehicle_params)
        flash[:notice] = "Veículo editado com sucesso!"
        redirect_to @carrier_vehicle
      else
        @errors = @carrier_vehicle.errors.full_messages
        render :edit
      end
  end

  def destroy
      if @carrier_vehicle.destroy
        flash[:notice] = 'Veículo deletado com sucesso!'
        redirect_to carrier_vehicles_path
      else
        flash[:alert] = 'Algo deu errado'
      end
  end

  private

  def authenticate_linked_user
    return redirect_to root_path if current_user.guest?
  end

  def carrier_vehicle_params
    params.require(:carrier_vehicle).permit(:license_plate, :brand, :model, :year, :maximum_load_capacity)
  end

  def set_carrier_vehicle_and_check_company
    @carrier_vehicle = CarrierVehicle.friendly.find(params[:id])
    return check_user_company()
  end

  def check_user_company
    if @carrier_vehicle.transport_company != current_user.transport_company
      redirect_to root_path, notice:"Você não deveria estar aqui"
    end
  end
end
