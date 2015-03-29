class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create
    # Amount in cents
  @amount = 1500

  customer = Stripe::Customer.create(
    :email => current_user.email,
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Tshirtgram T-shirt',
    :currency    => 'GBP'
  )


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path

      @addtosaletable=Sale.create(:email=>current_user.email, :user_id=>current_user.id, :amount=>@amount, :stripe_id=>customer.id,
      :stripe_token=>params[:stripeToken], :picture_id=>params[:picture_id], :size=>params[:size], :address=>params[:address], :country=>params[:country], :postal_code=>params[:postal_code], :card_expiration=>Date.new(charge.card.exp_year,charge.card.exp_month,1) )
    
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:email, :user_id, :picture_id, :amount, :size, :address, :country, :postal_code, :stripe_id, :stripe_token, :card_expiration)
    end
end
