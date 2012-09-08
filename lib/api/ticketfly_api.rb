require File.dirname(__FILE__) + "/event_api"
require File.dirname(__FILE__) + "/api_helper"

class Ticketfly
  include EventApi
  include ApiHelper

  def self.fetch
    startDate = Week.this_week.today.strtime('%Y-%m-%d')
    endDate = (Week.this_week.today + 1.week).strtime('%Y-%m-%d')
    orgs = '93,175,1417'
    query = "http://www.ticketfly.com/api/events/list.json?orgId=#{orgs}&fromDate=#{startDate}&thruDate=#{endDate}&maxResults=200"
    EventApi.get_http_response(query)
  end

end
