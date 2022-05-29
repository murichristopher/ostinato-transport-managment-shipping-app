class WorkOrdersController < ApplicationController
  before_action :authenticate_user, except: [:show]
  before_action :set_visibility, except: [:show]
  before_action :authenticate_admin!, except: [:index, :show]
  before_action :set_work_orders_and_check_company, only: [:show]

  def index
  end

  def show
  end

  def new
    @work_order = WorkOrder.new
  end

  def new_budget_assign
    @work_order = WorkOrder.new
  end

  def create_budget_assign
    @work_order = WorkOrder.new(work_order_params)

    transport_company = TransportCompany.friendly.find(params[:id])
    @work_order.transport_company = transport_company

    if @work_order.save
      redirect_to(@work_order, notice:"Ordem de Serviço cadastrada com sucesso!")
    else
      @errors = @work_order.errors.full_messages
      render :new_budget_assign
    end

  end

  def new_directly_assign
    @work_order = WorkOrder.new
  end

  def create_directly_assign
    @work_order = WorkOrder.new(work_order_params)
    transport_company = TransportCompany.friendly.find(params[:id])

    @work_order.transport_company = transport_company

    if @work_order.save
      redirect_to(@work_order, notice:"Ordem de Serviço cadastrada com sucesso!")
    else
      @errors = @work_order.errors.full_messages
      render :new_directly_assign
    end
  end

  def new_budget
  end

  def budget
    if params[:work_order].nil?
      return redirect_to root_path
    end

    @total_distance = params[:work_order][:total_distance].to_i

    @budgets = Price.where("cubic_meters_min <= ? AND cubic_meters_max >= ? AND weight_min <= ? AND weight_max >= ?", params[:work_order][:cubic_size], params[:work_order][:cubic_size], params[:work_order][:total_weight], params[:work_order][:total_weight]).group(:transport_company_id).where(transport_company_id: TransportCompany.where(status: "active"))


    @delivery_times = []
#  Price.where(transport_company_id: TransportCompany.where(status: "active"))

    @budgets.each do |budget|
      @delivery_times << budget.transport_company.delivery_times.find_by("km_min <= ? AND km_max >= ?", @total_distance, @total_distance)
    end

  end

  private

  def set_work_orders_and_check_company
    if current_user
      @work_order = WorkOrder.friendly.find(params[:id])
      return check_user_company()
    else
      @work_order = WorkOrder.friendly.find(params[:id])
    end
  end

  def check_user_company
    if @work_order.transport_company != current_user.transport_company
      redirect_to root_path, notice:"Você não deveria estar aqui"
    end
  end

  def work_order_params
    params.require(:work_order).permit(:sender_address, :receiver_address, :receiver_name, :receiver_cpf, :cubic_size, :total_weight, :total_distance)
  end

  def authenticate_user
    if current_user && current_user.guest?
      return redirect_to root_path
    elsif !current_user && !current_admin
      return redirect_to root_path
    end
  end

  def set_visibility
    if current_user && current_user.linked?
      @work_orders = current_user.transport_company.work_orders
    elsif current_admin
      @work_orders = WorkOrder.all
    end
  end

end
