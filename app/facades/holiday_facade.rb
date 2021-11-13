class HolidayFacade
#mini controller talks to controller, talks to poro,manipulates information
#give back to facade, and then to controller
  def self.holiday_information
    holiday_data = HolidayService.connection_to_holidays
    #HolidayPoro.new(holiday_data)
  end
end
