module ScriptsHelper
  def google_maps_directions_url(script)
    # Coleta todos os itens com localização, ordenados por data/hora
    items_with_location = script.script_items
                                .order(date_time_start: :asc)
                                .where.not(location: nil)
                                .where.not(location: '')
                                .pluck(:location)
                                .reject(&:blank?)
    
    return nil if items_with_location.empty?
    
    base_url = 'https://www.google.com/maps'
    
    case items_with_location.count
    when 1
      # Para 1 item, usa search
      location = ERB::Util.url_encode(items_with_location.first)
      "#{base_url}/search/?api=1&query=#{location}"
    when 2
      # Para 2 itens, usa directions com origin e destination
      origin = ERB::Util.url_encode(items_with_location.first)
      destination = ERB::Util.url_encode(items_with_location.last)
      "#{base_url}/dir/?api=1&origin=#{origin}&destination=#{destination}&travelmode=driving"
    else
      # Para 3+ itens, usa directions com origin, destination e waypoints
      origin = ERB::Util.url_encode(items_with_location.first)
      destination = ERB::Util.url_encode(items_with_location.last)
      waypoints = items_with_location[1..-2].map { |loc| ERB::Util.url_encode(loc) }.join('|')
      "#{base_url}/dir/?api=1&origin=#{origin}&destination=#{destination}&waypoints=#{waypoints}&travelmode=driving"
    end
  end
end
