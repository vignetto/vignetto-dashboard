module EventsHelper
  def event_date_price_and_length(event_date)
    "#{number_to_currency(event_date.event.ticket_price, precision: 0)} - #{distance_of_time_in_words(event_date.time_begin, event_date.time_end).gsub('about', '')}"
  end
end
