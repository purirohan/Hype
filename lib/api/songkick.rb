require File.dirname(__FILE__) + "/event_api"
require File.dirname(__FILE__) + "/api_helper"

class Songkick
  include EventApi
  include ApiHelper

  def self.fetch
    # class variable is listed on top of page
    # startDate = Time.parse("#{ApiHelper.weekend['monday']['day']}").strftime('%Y-%m-%d')
    # endDate = Time.parse("#{ApiHelper.weekend['sunday']['night']}").strftime('%Y-%m-%d')
    
    city = 'dc'
    query = "http://api.songkick.com/api/3.0/events.json?apikey=#{ApiSettings.songkick_key}&location=geo:#{ApiHelper.cities[city]["lat"]},#{ApiHelper.cities[city]["lon"]}"
    EventApi.get_http_response(query)
  end

end
