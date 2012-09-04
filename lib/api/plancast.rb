require File.dirname(__FILE__) + "/event_api"
require File.dirname(__FILE__) + "/api_helper"

class Plancast
  include EventApi
  include ApiHelper

  def self.fetch
    query = 'http://api.plancast.com/02/plans/search.json?q=party'
    pc_request = URI.parse(query)
    pc_array = Net::HTTP.get_response(pc_request).body
    plancast = JSON.parse(pc_array)

    EventApi.get_http_response(query)
  end
end
