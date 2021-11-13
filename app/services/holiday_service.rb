class HolidayService

  def self.connection_to_holidays
    response = Faraday.get('https://date.nager.at/api/v2/NextPublicHolidays/US')
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[0..2]
  end



end
