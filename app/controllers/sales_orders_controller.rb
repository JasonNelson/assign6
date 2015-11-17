class SalesOrdersController < ApplicationController
  before_action :set_sales_order, only: [:show, :edit, :update, :destroy]
  before_filter :check_for_cancel, :only => [:create, :update]

def check_for_cancel
  if params[:commit] == "Cancel"
    redirect_to new_sales_order_url
  end
end
  # GET /sales_orders
  # GET /sales_orders.json

  def index
    @sales_orders = SalesOrder.paginate(page: params[:page])
  end

  # GET /sales_orders/1
  # GET /sales_orders/1.json
  def show
  end

  # GET /sales_orders/new
  def new
    @sales_order = SalesOrder.new
  end

  # GET /sales_orders/1/edit
  def edit
  end

  # POST /sales_orders
  # POST /sales_orders.json
  def create
    @sales_order = SalesOrder.new(sales_order_params)

    respond_to do |format|
      if @sales_order.save
        flash[:success] = "Sales order was successfully created!"
        format.html { redirect_to @sales_order }
        format.json { render :show, status: :created, location: @sales_order }
      else
        format.html { render :new }
        format.json { render json: @sales_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_orders/1
  # PATCH/PUT /sales_orders/1.json
  def update
    respond_to do |format|
      if @sales_order.update(sales_order_params)
        flash[:success] = "Sales order was successfully updated!"
        format.html { redirect_to @sales_order }
        format.json { render :show, status: :ok, location: @sales_order }
      else
        format.html { render :edit }
        format.json { render json: @sales_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_orders/1
  # DELETE /sales_orders/1.json

  def destroy
    @sales_order.destroy
    flash[:success] = "Sales Order deleted"
    redirect_to request.referrer || root_url
  end

  # def destroy
  #   SalesOrder.find(params[:id]).destroy
  #   flash[:success] = "Sales Order deleted"
  #   redirect_to sales_orders_url
  # end

  # def destroy
  #   @sales_order.destroy
  #   respond_to do |format|
  #     format.html { redirect_to sales_orders_url, notice: 'Sales order was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_order
      @sales_order = SalesOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_order_params
      params.require(:sales_order).permit(:billing_street_add, :billing_city, :billing_state, :billing_zipcode, :shipping_street_address, :shipping_city, :shipping_state, :shipping_zipcode, :cc_fname, :cc_middle_initial, :cc_lname, :cc_number, :cc_security_code, :cc_exp_month, :cc_exp_year, :subtotal, :tax_percent, :shipping_fee, :total, :customer_account_id, :order_line_id, :order_status_id)
    end
end
