require 'active_support'

module FaradayConcern
  extend ActiveSupport::Concern
  
  def agiinfo_base_url
    "https://aginfo.cgk.affrc.go.jp/ws/rgeocode.php"
  end
  
  def agiinfo_paramators(latitude, longitude)
    "?json&lat=#{latitude}&lon=#{longitude}"
  end
  
  def connection(base_url)
    Faraday.new(url: base_url) do |builder|
      builder.request  :url_encoded
      builder.response :logger
      builder.response :json, parser_options: { symbolize_names: true }
      builder.adapter Faraday.default_adapter
    end
  end
  
  def reverse_geocode(latitude, longitude)
    (connection(agiinfo_base_url).get agiinfo_paramators(latitude, longitude)).body
  end
end
  
  
  
  
  
    
  
  