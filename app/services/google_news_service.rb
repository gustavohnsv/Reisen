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
      text = html.gsub(/<[^>]*>/, '').strip
      # Decodifica entidades HTML (&nbsp; &amp; etc)
      text = CGI.unescapeHTML(text)

      # Remove entidades HTML comuns
      text.gsub!('&nbsp;', ' ')
      text.gsub!('&amp;', '&')
      text.gsub!('&quot;', '"')
      text.gsub!('&apos;', "'")
      text.gsub!('&lt;', '<')
      text.gsub!('&gt;', '>')
      
      # Remove espaços múltiplos
      text.gsub(/\s+/, ' ').strip
    end

  end
end
