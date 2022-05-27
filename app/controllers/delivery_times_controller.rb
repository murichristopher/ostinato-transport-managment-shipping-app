class DeliveryTimesController < ApplicationController
  before_action :authenticate_linked_user
  before_action :set_delivery_time_and_check_company, only: [:show, :edit, :update, :destroy]

  def index
    @delivery_times = current_user.transport_company.delivery_times
  end

  def new
    @delivery_time = DeliveryTime.new
  end

  def show
  end

  def create
    @delivery_time = DeliveryTime.new(delivery_time_params)
    @delivery_time.transport_company = current_user.transport_company

    if @delivery_time.save
      redirect_to(delivery_times_path, notice:"Prazo de entrega cadastrado com sucesso!")
    else
      @errors = @delivery_time.errors.full_messages
      render :new
    end
  end

  def update
      if @delivery_time.update(delivery_time_params)
        flash[:notice] = "Prazo de entraga editado com sucesso!"
        redirect_to delivery_times_path
      else
        @errors = @price.errors.full_messages
        render :edit
      end
  end

  def destroy
    @delivery_time.destroy
    redirect_to delivery_index_path
  end

  private

  def authenticate_linked_user
    return redirect_to root_path if current_user.guest?
  end

  def delivery_time_params
    params.require(:delivery_time).permit(:km_min, :km_max, :time)
  end

  def set_delivery_time_and_check_company
    @delivery_time = DeliveryTime.friendly.find(params[:id])
    return check_user_company()
  end

  def check_user_company
    if @delivery_time.transport_company != current_user.transport_company
      redirect_to root_path, notice:"Você não deveria estar aqui"
    end
  end

end

