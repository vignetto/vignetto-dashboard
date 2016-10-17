FactoryGirl.define do
  factory :event_date do
    event
    time_begin      Date.today.at_noon
    time_end        Date.today.end_of_day
    tickets_total   10 
    tickets_sold    0 
    waitlist        false
  end
end