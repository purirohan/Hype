require File.dirname(__FILE__) + "/event_api"
require File.dirname(__FILE__) + "/api_helper"

class Ticketfly
  include EventApi
  include ApiHelper

  def self.fetch
    startDate = '2012-09-05'
    endDate = '2012-09-13'
    orgs = '93,175,1417'
    query = "http://www.ticketfly.com/api/events/list.json?orgId=#{orgs}&fromDate=#{startDate}&thruDate=#{endDate}&maxResults=200"
    EventApi.get_http_response(query)
  end

end
