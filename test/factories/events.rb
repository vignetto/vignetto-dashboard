FactoryGirl.define do
  factory :event do
    user
    publish         true
    private_event   false
    package         true
    title           'Jamieson Ranch Vineyards'
    short_description 'Jamieson Ranch Vineyards Winery'
    description     'Jamieson Ranch Vineyards is the southernmost winery in the Napa Valley.'
    ticket_price    150
  end
end
