require 'active_support'

module FaradayConcern
  extend ActiveSupport::Concern
  
  def reverse_geocode(latitude, longitude)
    (connection(agiinfo_base_url).get agiinfo_paramators(latitude, longitude)).body
  end
  
  def get_weather(pcode)
    (connection(weather_base_url).get weather_file_name(pcode)).body
  end
  
  private
  
  def connection(base_url)
    Faraday.new(url: base_url) do |builder|
      builder.request  :url_encoded
      builder.response :logger
      builder.response :json, parser_options: { symbolize_names: true }
      builder.adapter Faraday.default_adapter
    end
  end
  
  def agiinfo_base_url
    "https://aginfo.cgk.affrc.go.jp/ws/rgeocode.php"
  end
  
  def agiinfo_paramators(latitude, longitude)
    "?json&lat=#{latitude}&lon=#{longitude}"
  end
  
  def weather_base_url
    "https://www.jma.go.jp/bosai/forecast/data/overview_forecast/"
  end
  
  def weather_file_name(pcode)
    pcode = pcode.to_s
    if pcode == "1"
      code = "014100"
    elsif 
      pcode == "46"
      code = "460100"
    elsif pcode == "47"
      code = "471000"
    elsif pcode.size == 1
      code = "0#{pcode}0000"
    else
      code = "#{pcode}0000"
    end
    "#{code}.json"
  end
end