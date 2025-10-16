class NewsController < ApplicationController
  def index
    location = params[:location].presence
    @news = GoogleNewsService.fetch(location: location)
  end
end