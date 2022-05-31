class WorkOrdersController < ApplicationController
  before_action :authenticate_user, except: [:show, :search, :handle_search]
  before_action :set_visibility, except: [:show, :search, :handle_search]
  before_action :authenticate_admin!, except: [:index, :show, :accept, :refuse, :change_status, :search, :handle_search]
  before_action :set_work_order_and_check_company, only: [:accept, :refuse, :change_status]

  def search
  end

  def handle_search
    parametro = params[:work_order][:unique_code]
    @work_order = WorkOrder.find_by(unique_code: parametro.upcase)

    if @work_order.present?
     redirect_to @work_order, notice:"Sua busca foi encontrada!"
    else
      @errors = "Não foi encontrado!"
      render :search, notice:"Não foi possivel encontrar um Ordem de serviço com este código"
    end

  end

  def index
  end

  def show
    @work_order = WorkOrder.friendly.find(params[:id])

    if current_user
      @authenticated = current_user.transport_company == @work_order.transport_company
    end

    @work_order_routes = @work_order.work_order_routes.reverse()

    @carrier_vehicles = @work_order.transport_company.carrier_vehicles.where("maximum_load_capacity > ?", @work_order.total_weight)
  end

  def accept
   if current_user && current_user.transport_company == @work_order.transport_company
    redirect_to @work_order, notice:"Ordem de serviço foi aceita com sucesso!" if @work_order.aceita!
   end
  end

  def refuse
    if current_user && current_user.transport_company == @work_order.transport_company
      redirect_to @work_order, notice:"Ordem de serviço foi recusada com sucesso!" if @work_order.recusada!
   end
  end

  def destroy
    @work_order = WorkOrder.friendly.find(params[:id])

    return redirect_to work_order_path(@work_order), alert:"Não é permitido alterar Ordens de serviço que seu estado não sejam 'pendente' ou 'recusada'" if !@work_order.pendente? && !@work_order.recusada?

    @work_order.transport_company = nil
    @work_order.carrier_vehicle = nil

      if @work_order.destroy
        flash[:notice] = 'Ordem de serviço deletada com sucesso!'
        redirect_to work_orders_path
      else
        flash[:alert] = 'Algo deu errado'
        render :show
      end
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

    @budgets.each do |budget|
      delivery_time = budget.transport_company.delivery_times.find_by("km_min <= ? AND km_max >= ?", @total_distance, @total_distance)


      log = BudgetLog.new(transport_company: budget.transport_company, cubic_size: params[:work_order][:cubic_size], total_weight: params[:work_order][:total_weight], total_distance: params[:work_order][:total_distance])

      if delivery_time.present?
        log.delivery_time = delivery_time.time
      end

      log.total_price = log.total_distance * budget.value_per_km
      log.save!

      @delivery_times << delivery_time
    end



  end

  private

  def set_work_order_and_check_company
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
