class SoPickListsController < ApplicationController
  before_action :set_so_pick_list, only: [:show, :edit, :update, :destroy]

  # GET /so_pick_lists
  # GET /so_pick_lists.json
  def index
    @so_pick_lists = SoPickList.all
  end

  # GET /so_pick_lists/1
  # GET /so_pick_lists/1.json
  def show
  end

  # GET /so_pick_lists/new
  def new
    @so_pick_list = SoPickList.new
  end

  # GET /so_pick_lists/1/edit
  def edit
  end

  # POST /so_pick_lists
  # POST /so_pick_lists.json
  def create
    @so_pick_list = SoPickList.new(so_pick_list_params)

    respond_to do |format|
      if @so_pick_list.save
        format.html { redirect_to @so_pick_list, notice: 'So pick list was successfully created.' }
        format.json { render :show, status: :created, location: @so_pick_list }
      else
        format.html { render :new }
        format.json { render json: @so_pick_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /so_pick_lists/1
  # PATCH/PUT /so_pick_lists/1.json
  def update
    respond_to do |format|
      if @so_pick_list.update(so_pick_list_params)
        format.html { redirect_to @so_pick_list, notice: 'So pick list was successfully updated.' }
        format.json { render :show, status: :ok, location: @so_pick_list }
      else
        format.html { render :edit }
        format.json { render json: @so_pick_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /so_pick_lists/1
  # DELETE /so_pick_lists/1.json
  def destroy
    @so_pick_list.destroy
    respond_to do |format|
      format.html { redirect_to so_pick_lists_url, notice: 'So pick list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_so_pick_list
      @so_pick_list = SoPickList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def so_pick_list_params
      params.require(:so_pick_list).permit(:sales_order_id, :order_line_id)
    end
end
