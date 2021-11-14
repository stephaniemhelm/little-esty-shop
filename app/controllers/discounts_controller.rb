class DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.merchant_discounts
    @holidays = HolidayFacade.holiday_information
  end

  def show
    @discount = Discount.find(params[:id])
  end
end
