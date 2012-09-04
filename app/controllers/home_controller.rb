class HomeController < ApplicationController
  caches_page :index

  def index
    @groupon = Groupon.fetch
    @meetup = Meetup.fetch
    @eventbrite = Eventbrite.fetch
    @songkick = Songkick.fetch
    @active = Active.fetch
    @seatgeek = Seatgeek.fetch
    @plancast = Plancast.fetch
    @ticketfly = Ticketfly.fetch
  end
end
