require File.dirname(__FILE__) + "/event_api"

class Groupon
  include EventApi

  def self.fetch(city = 'nyc')
    city = 'new-york'
    query = "http://api.groupon.com/v2/deals.json?division_id=#{city}&client_id=#{ApiSettings.groupon_key}"
    return EventApi.get_http_response(query)
  end

end
