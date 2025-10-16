require 'net/http'
require 'uri'
require 'rss'
require 'httparty'

class GoogleNewsService
  class << self
    def fetch(location:)
      uri = google_news_uri(location:)
      response = HTTParty.get(uri, follow_redirects: true)

      # Debug
      puts "URL: #{uri}"
      puts "Status: #{response.code}"
      puts "Body (primeiros 500 chars): #{response.body[0..500]}"

      rss = RSS::Parser.parse(response.body)

      rss.items.map do |item|
        {
          title: item.title,
          description: strip_html(item.description),
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

    def strip_html(html)
      # Remove tags HTML básicas
      html.gsub(/<[^>]*>/, '').strip
    end

  end
end
