
tempsurvive.callback_get_humidity = function(pos, humidity)
    return humidity;
  end

tempsurvive.callback_get_temperatures = function(pos)
    local longtime_temp = tempsurvive.get_avarage_temperature(pos)
    return longtime_temp, longtime_temp, longtime_temp;
    --return actual_temp, shorttime_temp, longtime_temp;
  end
