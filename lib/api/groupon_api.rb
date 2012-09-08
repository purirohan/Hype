require File.dirname(__FILE__) + "/event_api"

class GrouponApi
  include EventApi

  def self.fetch(city = 'dc')
    city = 'washington-dc'
    query = "http://api.groupon.com/v2/deals.json?division_id=#{city}&client_id=#{ApiSettings.groupon_key}"
    return EventApi.get_http_response(query)
  end

end
