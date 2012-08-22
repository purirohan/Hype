module Active_api

	def active(day,city,amount = 200,page=false)
		if day == 'reset'
			day = 'all'
		end

		# sample startDate = '08%2F19%2F2011'
		startDate = Time.parse("#{@weekend[day]['day']}").strftime('%m %d %Y').gsub /\s/, '%2F'
		endDate = Time.parse("#{@weekend[day]['night']}").strftime('%m %d %Y').gsub /\s/, '%2F'

		key = 'cy72tu6xtta533bmqw875ppm'
		string = "http://api.amp.active.com/search?num=#{amount}&r=#{@cities[city]['radius']}&m=meta:startDate:daterange:#{startDate}...#{endDate}&v=json&l=#{@cities[city]['zip']}&api_key=#{key}"

		# process the query
		active = get_http_response(string)

		# if error in request
		unless active
			return nil
		end

		# filter the results
		count_it(active["_results"])
		add_measure(active["_results"],['meta','estParticipants'])
		# fill in the holes for estParticipants attribute
		active["_results"].each {|a| a["meta"]["estParticipants"] = 10 if a["meta"]["estParticipants"].blank?}
		active["_results"].sort! {|x,y| y["meta"]["estParticipants"].to_i <=> x["meta"]["estParticipants"].to_i} 
		replace_dups(active["_results"],'active')
		image_it(active["_results"],@average)

		return active
	end

	def active_page event_id
    # remove prefix
    event_id = event_id.gsub /active_/, ''

		key = 'rzyepehtzpb9usqdnzb65rmz'
		request = "http://api.amp.active.com/resource/assetservice/asset/#{event_id}?v=json&api_key=#{key}"

		# process the query
		get_http_response(request)
	end

end
