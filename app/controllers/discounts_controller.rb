class DiscountsController < ApplicationController

  def index
    @discounts = Discount.all
    @holidays = HolidayFacade.holiday_information
  end

  def show
    @discount = Discount.find(params[:id])
  end
end
