class TransportCompaniesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_transport_company, only: [:show, :edit, :update, :toggle_status]

  def index
    @active_transport_companies = TransportCompany.active
    @inactive_transport_companies = TransportCompany.inactive
  end

  def new
    @transport_company = TransportCompany.new
  end

  def create
    @transport_company = TransportCompany.new(transport_company_params)

    if @transport_company.save
      redirect_to(@transport_company, notice:"Transportadora cadastrada com sucesso!")
    else
      @errors = @transport_company.errors.full_messages
      flash[:error] = "Algo deu errado"
      render 'new'
    end
  end

  def show
    @prices = @transport_company.prices
    @delivery_times = @transport_company.delivery_times
  end

  def toggle_status
    if @transport_company.active?
      @transport_company.inactive!
    elsif @transport_company.inactive?
      @transport_company.active!
    end

    redirect_to @transport_company
  end

  def edit
  end

  def update
    if  @transport_company.update(transport_company_params)
      flash[:notice] = "Transportadora editada com sucesso!"
      redirect_to(@transport_company)

    else
      @errors = @transport_company.errors.full_messages
      flash.now[:notice] = "Algo deu errado"
      render :edit
    end
  end


  private

  def transport_company_params
    params.require(:transport_company).permit(:trading_name, :company_name, :domain, :registration_number, :full_address)
  end

  def set_transport_company
    @transport_company = TransportCompany.friendly.find(params[:id])
  end
end
