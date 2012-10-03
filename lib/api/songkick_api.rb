require File.dirname(__FILE__) + "/event_api"
require File.dirname(__FILE__) + "/api_helper"

class SongkickApi
  include EventApi
  include ApiHelper

  def self.fetch
    startDate = Week.this_week.today.strftime('%Y-%m-%d')
    endDate = (Week.this_week.today + 1.week).strftime('%Y-%m-%d')
    
    city = 'dc'
    query = "http://api.songkick.com/api/3.0/events.json?apikey=#{ApiSettings.songkick_key}&location=geo:#{ApiHelper.cities[city]["lat"]},#{ApiHelper.cities[city]["lon"]}&min_date=#{startDate}&max_date=#{endDate}"
    EventApi.get_http_response(query)
  end

end
