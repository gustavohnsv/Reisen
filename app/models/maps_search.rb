class MapsSearch
  include ActiveModel::Model

  attr_accessor :query

  validates :query, presence: true

  BASE_URL = 'https://www.google.com/maps/search/?api=1'.freeze

  def to_url
    raise ArgumentError, 'query is required' if query.to_s.strip.empty?

    encoded_query = CGI.escape(query.to_s.strip)
    "#{BASE_URL}&query=#{encoded_query}"
  end
end

