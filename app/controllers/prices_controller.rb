class PricesController < ApplicationController
  before_action :authenticate_linked_user!
  before_action :set_price_and_check_company, only: [:show, :edit, :update, :destroy]

  def index
    @prices = current_user.transport_company.prices
  end

  def new
    @price = Price.new
  end

                                                                                        def create
                                                                                          @price = Price.new(price_params)

                                                                                          @price.transport_company = current_user.transport_company

                                                                                          if @price.save
                                                                                            redirect_to(prices_path, notice:"Preço cadastrado com sucesso!")
                                                                                          else
                                                                                            @errors = @price.errors.full_messages
                                                                                            render :new
                                                                                          end
                                                                                        end

  def edit
  end

  def update
      if @price.update(price_params)
        flash[:notice] = "Preço editado com sucesso!"
        redirect_to prices_path
      else
        @errors = @price.errors.full_messages
        render :edit
      end
  end

  def destroy
      if @price.destroy
        flash[:notice] = 'Preço deletado com sucesso!'
        redirect_to prices_path
      else
        flash[:alert] = 'Algo deu errado'
      end
  end

  private

  def price_params
    params.require(:price).permit(:cubic_meters_min, :cubic_meters_max, :weight_min, :weight_max, :value_per_km)
  end

  def authenticate_linked_user!
    return redirect_to root_path if current_user.guest?
  end

  def set_price_and_check_company
    @price = Price.friendly.find(params[:id])
    return check_user_company()
  end

  def check_user_company
    if @price.transport_company != current_user.transport_company
      redirect_to root_path, notice:"Você não deveria estar aqui"
    end
  end

end
