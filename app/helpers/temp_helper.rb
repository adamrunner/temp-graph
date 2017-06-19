module TempHelper
  def format_time(date_time)
    date_time.strftime("%Y-%m-%d %H:%I:%S %Z") if date_time
  end
end
