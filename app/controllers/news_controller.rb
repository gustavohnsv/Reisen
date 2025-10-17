class NewsController < ApplicationController
  def index
    location = params[:location].presence
    @news = GoogleNewsService.fetch(location: location)
    @news.sort_by! do |item|
    begin
      Date.strptime(item[:pubDate].to_s.strip, '%d/%m/%Y')
    rescue
      Date.new(0)
    end
    end.reverse!
  end
end