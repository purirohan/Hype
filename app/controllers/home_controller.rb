class HomeController < ApplicationController
  caches_page :index

  def index
    @week = Week.this_week
    @groupon = GrouponApi.fetch
    @meetup = MeetupApi.fetch
    @eventbrite = EventbriteApi.fetch
    @songkick = SongkickApi.fetch
    @active = ActiveApi.fetch
    @seatgeek = SeatgeekApi.fetch
    @plancast = PlancastApi.fetch
    @ticketfly = TicketflyApi.fetch
  end
end
