FactoryGirl.define do
  factory :payment do
    user
    event
    event_date
    tickets           2
    full_name		      
    amount            50
    stripe_charge_id    
    stripe_email      
    description
    statement_descriptor
    status
    paid
    card_brand
    card_four
    address
    city
    state
    zipcode
  end

end
