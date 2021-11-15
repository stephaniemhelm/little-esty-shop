class DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.merchant_discounts
    @holidays = HolidayFacade.holiday_information
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = Discount.new(discount_params)

    if discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      flash[:alert] = "Please enter a valid information"
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
    @discount.update(discount_params)

    if @discount.save
      redirect_to merchant_discount_path(@merchant, @discount)
    else
      flash[:alert] = "Please enter a valid information"
      render :update
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(discount_params[:id])
    discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  private

    def discount_params
      params.permit(:id,:percentage, :quantity_threshold, :merchant_id)
    end

end
