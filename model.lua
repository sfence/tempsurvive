
tempsurvive.temp_model = {
  altitude_temp = {
      -- 6.4 degrees of Celsius down per 1000m
      lin_coef = 0.0064,
      const_temp = -273,
      callback = function (y)
          y = y/-200;
          local weather_ratio = (1.19^y+3^y)/2;
          local highaltitude_ratio = (1-weather_ratio);
          return weather_ratio, highaltitude_ratio;
        end,
    },
  undergound_temp = {
      -- 1 degrees of Celsius up per 33m
      lin_coef = -0.0303,
      callback = function (y)
          local weather_ratio = 3^y;
          local shorttime_ratio = ((1.19^y+3^y)/2)*(1-weather_ratio);
          local longtime_ratio = 1-shorttime_ratio-weather_ratio;
          return weather_ratio, shorttime_ration, longtime_ration;
        end,
   },
  moon_light = 2,
  sun_light_lin_coef = 0.25,
  --sun_light_lin_coef_callback = function() return coef; end,
  nosun_light_lin_coef = 0.1,
};

-- load model from file if posible
local this_mod_path = minetest.get_modpath(minetest.get_current_modname());

local function dofile_if_exists(filename)
  local f = loadfile(filename);
  if (f~=nil) then
    return f();
  end
  
  return;
end

if (tempsurvive.temp_model_file~=nil) then
  local temp_model_file = this_mod_path.."/"..tempsurvive.temp_model_file;
  
  dofile_if_exists(temp_model_file)

  minetest.log("warning", "temp model: "..dump(tempsurvive.temp_model));
end

