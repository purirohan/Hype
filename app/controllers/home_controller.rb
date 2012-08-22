class HomeController < ApplicationController
  caches_page :index

  def index
    @groupon = Groupon.fetch
    @meetup = Meetup.fetch
    @eventbrite = Eventbrite.fetch
  end
end
