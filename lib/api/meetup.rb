require File.dirname(__FILE__) + "/event_api"

class Meetup
  include EventApi

  def self.fetch 
    key = ApiSettings.meetup_key
    city = '10010'
    request = "https://api.meetup.com/2/open_events?key=#{key}&sign=true&zip=#{city}&order=trending&desc=true&page=100"
    # pass uri to https request function
    EventApi.get_https(request)
  end

  # To change this template use File | Settings | File Templates.
  def self.meetup(day,city = 'nyc',amount=100,page=false)
    key = ApiSettings.meetup_key
    meetup = []
    i = 0
    # loop through the days
    if day == 'all' or day == '1' or day == 'reset'
      @weekend.each do |w|
        if w[0] != 'all'
          startDate = Time.parse("#{w[1]['day']}").to_i
          endDate = Time.parse("#{w[1]['night']}").to_i
          startDate = startDate.to_s + '000'
          endDate = endDate.to_s + '000'
          request = "https://api.meetup.com/2/open_events?key=#{key}&sign=true&zip=#{@cities[city]["zip"]}&radius=#{@cities[city]["radius2"]}&order=trending&desc=true&page=#{amount}&time=#{startDate},#{endDate}"
          # pass uri to https request function
          returned = JSON.parse(get_https(request))
          i = i + 1
          meetup[i] = returned
        end
      end
    else
      startDate = Time.parse("#{@weekend[day]['day']}").to_i
      endDate = Time.parse("#{@weekend[day]['night']}").to_i
      startDate = startDate.to_s + '000'
      endDate = endDate.to_s + '000'
      request = "https://api.meetup.com/2/open_events?key=#{key}&sign=true&zip=#{@cities[city]["zip"]}&radius=#{@cities[city]["radius2"]}&order=trending&desc=true&page=#{amount}&time=#{startDate},#{endDate}"
      # pass uri to https request function
      returned = JSON.parse(get_https(request))
      meetup.push(returned)
    end

    # filter the results through these fine methods
    # count = meetup[3] ? 300 : 100
    # average = count / 9
    # replace_dups(meetup,'meetup')

    return meetup
  end

  def meetup_page event_id
    # remove prefix
    event_id = event_id.gsub /meetup_/, ''
		hash = Hash.new

		request = "https://api.meetup.com/2/events?key=#{key}&sign=true&event_id=#{event_id}&page=20"
    hash['data'] = JSON.parse(get_https(request))

		hash['data']['results'].each do |m|
			request = "https://api.meetup.com/2/groups?key=#{key}&sign=true&group_id=#{m['group']['id']}&page=20"
			hash['data']['results'][0]['extra_group_info'] = JSON.parse(get_https(request))
		end

		return hash
  end

end
