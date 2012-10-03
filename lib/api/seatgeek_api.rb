require File.dirname(__FILE__) + "/event_api"
require File.dirname(__FILE__) + "/api_helper"

class SeatgeekApi
  include EventApi
  include ApiHelper

  def self.fetch
    amount = 500
    city = 'dc'
    query = "http://api.seatgeek.com/1/events/in_your_area.json?zipcode=#{ApiHelper.cities[city]['zip']}&limit=#{amount}"
    seatgeek = EventApi.get_http_response(query)
    # check_dates(seatgeek) # if needed
  end

  def check_dates(seatgeek)
    seatgeek["events"].delete_if do |s| 
      s["date"] != Week.this_week.today.strftime('%B %d %Y')
    end
  end

  # original library code from theweekendmap
  def seatgeek(day,city,amount=500,page=false)
    query = "http://api.seatgeek.com/1/events/in_your_area.json?zipcode=#{@cities[city]['zip']}&limit=#{amount}"
    seatgeek = get_http_response(query)

    # if error in request
    unless seatgeek
      return nil
    end

    # delete that are not within dates
    if day == 'all' or day == 'reset'
      seatgeek["events"].each do |s| 
        if s["date"] != Time.parse("#{@weekend['friday']['day']}").strftime('%B %d %Y') or s["date"] != Time.parse("#{@weekend['saturday']['day']}").strftime('%B %d %Y') or s["date"] != Time.parse("#{@weekend['sunday']['day']}").strftime('%B %d %Y')
          s["validity"] = false
        end
      end
    else
      seatgeek["events"].delete_if do |s| 
        s["date"] != Time.parse("#{@weekend[day]['day']}").strftime('%B %d %Y')
      end
    end

    # determine amount of results belong to each set of popularity point
    count_it(seatgeek["events"])
    sort_it(seatgeek["events"],'average_price')
    image_it(seatgeek["events"],@average)
    replace_dups(seatgeek["events"],'seatgeek')

    return seatgeek
  end
end
