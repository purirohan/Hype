require File.dirname(__FILE__) + "/event_api"
require File.dirname(__FILE__) + "/api_helper"

class Eventbrite
  include EventApi
  include ApiHelper

  def self.fetch
    city = 'dc'
    query = "http://www.eventbrite.com/json/event_search?app_key=#{ApiSettings.eventbrite_key}&latitude=#{ApiHelper.cities[city]["lat"]}&longitude=#{ApiHelper.cities[city]["lon"]}&within=#{ApiHelper.cities[city]["radius"]}"
    EventApi.get_http_response(query)
  end

  # To change this template use File | Settings | File Templates.
  def eventbrite(category,city = 'nyc',amount = '100',page = false)
    eb_key = ApiSettings.eventbrite_key
    # for repeat query searches
    @e_brites = []

    # loop through each category to make a query
    if category == 'all' or category.empty? or category == 'reset'
      @all_cats.each do |ac, image|
        startDate = Time.parse("#{@weekend['all']['day']}").strftime('%Y-%m-%d')
        endDate = Time.parse("#{@weekend['all']['night']}").strftime('%Y-%m-%d')
        query = "http://www.eventbrite.com/json/event_search?app_key=#{eb_key}&latitude=#{@cities[city]["lat"]}&longitude=#{@cities[city]["lon"]}&max=#{amount}&within=#{@cities[city]["radius"]}&category=#{ac}&date=#{startDate}%20#{endDate}"
        e_array = get_http_response(query)
        if e_array
          e_array["events"].push(image)
          @e_brites.push(e_array["events"])
        else
          return nil
        end
      end
    else

      # run api query and filter by category
      @all_cats.each do |ac, image|
        # category id's are 1 char while day filters are spelled out
        if category == 'friday' or category == 'saturday' or category == 'sunday'
          # run query for particular day as param
          date = Time.parse("#{@weekend[category]['night']}").strftime('%Y-%m-%d')
          query = "http://www.eventbrite.com/json/event_search?app_key=#{eb_key}&latitude=#{@cities[city]["lat"]}&longitude=#{@cities[city]["lon"]}&max=#{amount}&within=#{@cities[city]["radius"]}&category=#{ac}&date=#{date}"
          e_array = get_http_response(query)
          if e_array
            @e_brites.push(e_array["events"])
          else
            return nil
          end
        else
          if image == category
            startDate = Time.parse("#{@weekend['all']['day']}").strftime('%Y-%m-%d')
            endDate = Time.parse("#{@weekend['all']['night']}").strftime('%Y-%m-%d')
            query = "http://www.eventbrite.com/json/event_search?app_key=#{eb_key}&latitude=#{@cities[city]["lat"]}&longitude=#{@cities[city]["lon"]}&max=#{amount}&within=#{@cities[city]["radius"]}&category=#{ac}&date=#{startDate}%20#{endDate}"
            e_array = get_http_response(query)
            if e_array
              @e_brites.push(e_array["events"])
            else
              return nil
            end
          end
        end
      end
    end

    # filter the results through these fine methods
    count = 0
    @e_brites.each do |event|
      count = count + event.count - 1
      event.each do |e|
        if e["event"] and e["event"]["venue"]
          eb = e["event"]["num_attendee_rows"]
          # manually set each popularity key by its num_attendee_rows data
          if eb < 10
            pop = 9
          elsif eb > 9 and eb < 20
            pop = 8
          elsif eb > 19 and eb < 30
            pop = 7
          elsif eb > 29 and eb < 40
            pop = 6
          elsif eb > 39 and eb < 50
            pop = 5
          elsif eb > 49 and eb < 60
            pop = 4
          elsif eb > 59 and eb < 70
            pop = 3
          elsif eb > 69 and eb < 80
            pop = 2
          elsif eb > 79
            pop = 1
          end
          # insert key value pair of imageMarker in hash
          e["event"]["mapImageMarker"] = pop
          # insert popularity Measure value in hash
          e["event"]["popularityMeasure"] = e["event"]["num_attendee_rows"]
        end
      end
    end
    average = count / 9

    replace_dups(@e_brites,'eventbrite')

    # return the e_brites array with nested events
    return @e_brites
  end

  def eventbrite_page event_id
    # remove prefix
    event_id = event_id.gsub /eventbrite_/, ''

    query = "http://www.eventbrite.com/json/event_get?app_key=#{eb_key}&id=#{event_id}"
    EventApi.get_http_response(query)
  end

end
