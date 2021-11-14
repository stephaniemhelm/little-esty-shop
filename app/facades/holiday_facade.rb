class HolidayFacade
  def self.holiday_information
    holiday_data = HolidayService.connection_to_holidays
  end
end
