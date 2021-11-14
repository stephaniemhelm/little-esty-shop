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
    @discount = Discount.new
    #require "pry"; binding.pry
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.new(discount_params)
    #require "pry"; binding.pry

    if @discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      flash[:alert] = "Please enter a valid information"
      render :new
    end

  end

  private

    def discount_params
      params.permit(:percentage, :quantity_threshold, :merchant_id)
    end

end
