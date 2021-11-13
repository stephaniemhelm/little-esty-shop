class HolidayPoro

  def initialize(holiday_data)
    @name = information(holiday_data[:name])
    @date = information(holiday_data[:date])
  end

  def information(holiday_data)
    holiday_data.map do |data|
      @name = data[:name],
      @date = data[:date]
    end
  end

end
