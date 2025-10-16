require 'net/http'
require 'uri'
require 'rss'
require 'httparty'
require 'cgi'

class GoogleNewsService
  class << self
    def fetch(location:)
      uri = google_news_uri(location:)
      response = HTTParty.get(uri, follow_redirects: true)

      rss = RSS::Parser.parse(response.body)

      rss.items.map do |item|
        {
          title: item.title,
          pubDate: item.pubDate.strftime('%d/%m/%Y'),
          link: item.link
        }
      end
    end

    private

    def google_news_uri(location:)
      query = location ? "Turismo+#{location}" : "Turismo"
      url = "https://news.google.com/rss/search?q=#{query}&hl=pt-BR"
      URI(url)
    end

  end
end
