# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.

# Participant users
user_participant_1 = User.create(email: 'part_1@vignetto.com', name: "Test Participant 1", role: User::roles[:participant], password: "testing123", password_confirmation: "testing123", confirmed_at: Date.today, address: "123 Vignetto St.", city: "Calistoga", zipcode: 94515, phone: "916-456-7894")
user_participant_2 = User.create(email: 'part_2@vignetto.com', name: "Test Participant 2", role: User::roles[:participant], password: "testing123", password_confirmation: "testing123", confirmed_at: Date.today, address: "123 Vignetto St.", city: "Calistoga", zipcode: 94515, phone: "914-123-1234") 
user_participant_3 = User.create(
  email: 'part_3@vignetto.com', 
  name: "Test Participant 3", 
  role: User::roles[:participant], 
  password: "testing123",
  password_confirmation: "testing123",
  confirmed_at: Date.today,
  address: "111 All Wine St.",
  city: "Calistoga",
  zipcode: 94515,
  phone: "914-444-5555" 
)

# Package
package_1 = Event.create(
	user_id: user.id,
	publish: true,
	private_event: false,
  package: true,
  title: 'Jamieson Ranch Vineyards',
  short_description: 'Jamieson Ranch Vineyards is the southernmost winery in the Napa Valley...',
  description: "Jamieson Ranch Vineyards is the southernmost winery in the Napa Valley, one of the world’s foremost winemaking regions. 
  The estate’s more than 300 acres of gently rolling hills and terraced vineyards benefit from the cooling fog and breezes from the nearby 
  San Pablo Bay, climatic conditions that favor the production of exceptional Pinot Noir and Chardonnay.",
  ticket_price: 150
)
ei_1 = EventItem.create(
  event_id: package_1.id,
  position: 0,
  name: 'Juan Jose Verdina, Winemaker',
  description: "Born in Chile, Juan Jose earned his degree in Agricultural Engineering from INACAP Tabancura in Santiago. His desire for practical experience brought him to Hahn Estates in the Santa Lucia Highlands of Monterey in September of 2002, where served under then President (and current JRV President) Bill Leigon. Juan Jose excelled at winemaking and quickly rose up the ranks working as Enologist, Cellar Master, Bottling Line Supervisor and Assistant Winemaker. Juan Jose’s dedication to his craft is absolute. He will be a tremendous asset to the company moving forward, states Leigon."
  )
ei_2 = EventItem.create(
  event_id: package_1.id,
  position: 1,
  name: 'JRV Tour & Tasting',
  description: "Enjoy our latest releases of award winning wines in a specially tailored wine tasting experience. Tasting are offered daily 12 p.m. - 4:30 p.m.",
  itinerary_item: true,
  itinerary_description: 'wine tasting',
  itinerary_begin: '2015-06-02 12:00:00',
  itinerary_end: '2015-06-02 16:30:00',
  show_map: true,
  address: '1 Kirkland Ranch Road',
  city: 'American Canyon',
  state: 'CA',
  zipcode: 94503,
  latitude: 38.2203669,
  longitude: -122.228834
  )
ei_3 = EventItem.create(
  event_id: package_1.id,
  position: 3,
  name: 'JRV Veranda Cheese Pairing',
  description: "Charm your palate with a specially crafted cheese plate that is paired with specifically chosen  JRV wines. Enjoy this culinary delight on our veranda with sweeping views of our property.",
  itinerary_item: true,
  itinerary_description: 'cheese pairing',
  itinerary_begin: '2015-06-02 17:00:00',
  itinerary_end: '2015-06-02 18:00:00',
  show_map: true,
  address: '1000 Lodi Ln',
  city: 'St. Helena',
  state: 'CA',
  zipcode: 94574,
  latitude: 38.255442,
  longitude: -122.351327
  )
ed_1 = EventDate.create( event_id: package_1.id, time_begin: '2015-06-02 10:00:00', time_end: '2015-06-02 12:00:00', tickets_total: 10, tickets_sold: 10, waitlist: false)
ed_2 = EventDate.create( event_id: package_1.id, time_begin: '2015-06-05 10:00:00', time_end: '2015-06-05 12:00:00', tickets_total: 10, tickets_sold: 0, waitlist: true)
ed_3 = EventDate.create( event_id: package_1.id, time_begin: '2015-06-09 12:00:00', time_end: '2015-06-09 17:00:00', tickets_total: 20, tickets_sold: 6, waitlist: false)
ed_4 = EventDate.create( event_id: package_1.id, time_begin: '2015-10-09 12:00:00', time_end: '2015-10-09 17:00:00', tickets_total: 15, tickets_sold: 0, waitlist: true)
package_1.event_items << [ei_1, ei_2, ei_3]
package_1.event_dates << [ed_1, ed_2, ed_3]


package_2 = Event.create(
	user_id: user.id,
	publish: true,
	private_event: false,
  package: true,
  title: 'Sonoma Raceway Drive and Taste',
  short_description: 'Drive around the racetrack then enjoy dinner.',
  description: "Jamieson Ranch Vineyards is the southernmost winery in the Napa Valley, one of the world’s foremost winemaking regions.
  The estate’s more than 300 acres of gently rolling hills and terraced vineyards benefit from the cooling fog and breezes from the nearby
  San Pablo Bay, climatic conditions that favor the production of exceptional Pinot Noir and Chardonnay.",
  ticket_price: 250
)

ei_4 = EventItem.create(
  event_id: package_2.id,
  position: 1,
  name: 'Drive a Ferrari',
  description: "Enjoy our latest releases of award winning wines in a specially tailored wine tasting experience. Tasting are offered daily 12 p.m. - 4:30 p.m.",
  itinerary_item: true,
  itinerary_description: 'wine tasting',
  itinerary_begin: '2015-06-02 12:00:00',
  itinerary_end: '2015-06-02 16:30:00',
  show_map: true,
  address: '1 Kirkland Ranch Road',
  city: 'American Canyon',
  state: 'CA',
  zipcode: 94503,
  latitude: 38.2203669,
  longitude: -122.228834
  )
ei_5 = EventItem.create(
  event_id: package_1.id,
  position: 3,
  name: 'Drink Wine',
  description: "Charm your palate with a specially crafted cheese plate that is paired with specifically chosen  JRV wines. Enjoy this culinary delight on our veranda with sweeping views of our property.",
  itinerary_item: true,
  itinerary_description: 'Drive and wine',
  itinerary_begin: '2015-06-02 17:00:00',
  itinerary_end: '2015-06-02 18:00:00',
  show_map: false,
  )
ed_1 = EventDate.create( event_id: package_2.id, time_begin: '2015-06-02 10:00:00', time_end: '2015-06-02 12:00:00', tickets_total: 10, tickets_sold: 10, waitlist: false)
ed_2 = EventDate.create( event_id: package_2.id, time_begin: '2015-06-05 10:00:00', time_end: '2015-06-05 12:00:00', tickets_total: 10, tickets_sold: 0, waitlist: true)
ed_3 = EventDate.create( event_id: package_2.id, time_begin: '2015-06-09 12:00:00', time_end: '2015-06-09 17:00:00', tickets_total: 20, tickets_sold: 6, waitlist: false)
ed_4 = EventDate.create( event_id: package_2.id, time_begin: '2015-10-09 12:00:00', time_end: '2015-10-09 17:00:00', tickets_total: 15, tickets_sold: 0, waitlist: true)
package_2.event_items << [ei_4, ei_5]
package_2.event_dates << [ed_1, ed_2, ed_3]

package_3 = Event.create(
	user_id: user.id,
	publish: true,
	private_event: false,
  package: true,
  title: 'Wine Train Evening',
  short_description: 'Take a trip on the wine train',
  description: "Jamieson Ranch Vineyards is the southernmost winery in the Napa Valley, one of the world’s foremost winemaking regions.
  The estate’s more than 300 acres of gently rolling hills and terraced vineyards benefit from the cooling fog and breezes from the nearby
  San Pablo Bay, climatic conditions that favor the production of exceptional Pinot Noir and Chardonnay.",
  ticket_price: 250
)

ei_6 = EventItem.create(
  event_id: package_3.id,
  position: 3,
  name: 'Choo Choo!',
  description: "Charm your palate with a specially crafted cheese plate that is paired with specifically chosen  JRV wines. Enjoy this culinary delight on our veranda with sweeping views of our property.",
  itinerary_item: true,
  itinerary_description: 'Get on the Train',
  itinerary_begin: '2015-06-02 17:00:00',
  itinerary_end: '2015-06-02 18:00:00',
  show_map: false,
  )
ed_1 = EventDate.create( event_id: package_3.id, time_begin: '2015-06-02 10:00:00', time_end: '2015-06-02 12:00:00', tickets_total: 10, tickets_sold: 10, waitlist: false)
ed_2 = EventDate.create( event_id: package_3.id, time_begin: '2015-06-05 10:00:00', time_end: '2015-06-05 12:00:00', tickets_total: 10, tickets_sold: 0, waitlist: true)
ed_3 = EventDate.create( event_id: package_3.id, time_begin: '2015-06-09 12:00:00', time_end: '2015-06-09 17:00:00', tickets_total: 20, tickets_sold: 6, waitlist: false)
ed_4 = EventDate.create( event_id: package_3.id, time_begin: '2015-10-09 12:00:00', time_end: '2015-10-09 17:00:00', tickets_total: 15, tickets_sold: 0, waitlist: true)
package_3.event_items << [ei_6]
package_3.event_dates << [ed_1, ed_2, ed_3]

package_4 = Event.create(
	user_id: user.id,
	publish: true,
	private_event: false,
  package: true,
  title: 'Wine Cavern Dinner Tour',
  short_description: 'Dine deep in the wine caves of Napa.',
  description: "Jamieson Ranch Vineyards is the southernmost winery in the Napa Valley, one of the world’s foremost winemaking regions.
  The estate’s more than 300 acres of gently rolling hills and terraced vineyards benefit from the cooling fog and breezes from the nearby
  San Pablo Bay, climatic conditions that favor the production of exceptional Pinot Noir and Chardonnay.",
  ticket_price: 250
)


ei_7 = EventItem.create(
  event_id: package_4.id,
  position: 3,
  name: 'Wine Cavern Dining',
  description: "Charm your palate with a specially crafted cheese plate that is paired with specifically chosen  JRV wines. Enjoy this culinary delight on our veranda with sweeping views of our property.",
  itinerary_item: true,
  itinerary_description: 'Caves are scary',
  itinerary_begin: '2015-06-02 17:00:00',
  itinerary_end: '2015-06-02 18:00:00',
  show_map: false,
  )
ed_1 = EventDate.create( event_id: package_4.id, time_begin: '2015-06-02 10:00:00', time_end: '2015-06-02 12:00:00', tickets_total: 10, tickets_sold: 10, waitlist: false)
ed_2 = EventDate.create( event_id: package_4.id, time_begin: '2015-06-05 10:00:00', time_end: '2015-06-05 12:00:00', tickets_total: 10, tickets_sold: 0, waitlist: true)
ed_3 = EventDate.create( event_id: package_4.id, time_begin: '2015-06-09 12:00:00', time_end: '2015-06-09 17:00:00', tickets_total: 20, tickets_sold: 6, waitlist: false)
ed_4 = EventDate.create( event_id: package_4.id, time_begin: '2015-10-09 12:00:00', time_end: '2015-10-09 17:00:00', tickets_total: 15, tickets_sold: 0, waitlist: true)
package_4.event_items << [ei_7]
package_4.event_dates << [ed_1, ed_2, ed_3]

package_5 = Event.create(
	user_id: user.id,
	publish: true,
	private_event: false,
  package: false,
  title: 'Non Package Event',
  short_description: 'This is a non package event...',
  description: "Jamieson Ranch Vineyards is the southernmost winery in the Napa Valley, one of the world’s foremost winemaking regions.
  The estate’s more than 300 acres of gently rolling hills and terraced vineyards benefit from the cooling fog and breezes from the nearby
  San Pablo Bay, climatic conditions that favor the production of exceptional Pinot Noir and Chardonnay.",
  ticket_price: 250
)

package_6 = Event.create(
	user_id: user.id,
	publish: true,
	private_event: false,
  package: false,
  title: 'Velveeta Invitational',
  short_description: "It's the cheesiest.",
  description: "Taste the best cheese in the west.",
  ticket_price: 10
)

ei_8 = EventItem.create(
  event_id: package_6.id,
  position: 3,
  name: 'Velveeta Tasting',
  description: "Charm your palate with a specially crafted cheese plate that is paired with specifically chosen  JRV wines. Enjoy this culinary delight on our veranda with sweeping views of our property.",
  itinerary_item: true,
  itinerary_description: 'It melts',
  itinerary_begin: '2015-06-02 17:00:00',
  itinerary_end: '2015-06-02 18:00:00',
  show_map: false,
  )
ed_1 = EventDate.create( event_id: package_6.id, time_begin: '2015-06-02 10:00:00', time_end: '2015-06-02 12:00:00', tickets_total: 10, tickets_sold: 10, waitlist: false)
ed_2 = EventDate.create( event_id: package_6.id, time_begin: '2015-06-05 10:00:00', time_end: '2015-06-05 12:00:00', tickets_total: 10, tickets_sold: 0, waitlist: true)
ed_3 = EventDate.create( event_id: package_6.id, time_begin: '2015-06-09 12:00:00', time_end: '2015-06-09 17:00:00', tickets_total: 20, tickets_sold: 6, waitlist: false)
ed_4 = EventDate.create( event_id: package_6.id, time_begin: '2015-10-09 12:00:00', time_end: '2015-10-09 17:00:00', tickets_total: 15, tickets_sold: 0, waitlist: true)
package_6.event_items << [ei_8]
package_6.event_dates << [ed_1, ed_2, ed_3]

package_7 = Event.create(
	user_id: user.id,
	publish: true,
	private_event: false,
  package: false,
  title: 'Sour Grape Winefest',
  short_description: 'Sour grape wine fun',
  description: "Sour grapes make sour wine. Come try it!",
  ticket_price: 30
)

ei_8 = EventItem.create(
  event_id: package_7.id,
  position: 3,
  name: 'Sour Grape Wine Tasting',
  description: "Charm your palate with a specially crafted cheese plate that is paired with specifically chosen  JRV wines. Enjoy this culinary delight on our veranda with sweeping views of our property.",
  itinerary_item: true,
  itinerary_description: 'It is a sour experience',
  itinerary_begin: '2015-06-02 17:00:00',
  itinerary_end: '2015-06-02 18:00:00',
  show_map: true,
  address: '1 Kirkland Ranch Road',
  city: 'American Canyon',
  state: 'CA',
  zipcode: 94503,
  latitude: 38.2203669,
  longitude: -122.228834

  )
ed_1 = EventDate.create( event_id: package_7.id, time_begin: '2015-06-02 10:00:00', time_end: '2015-06-02 12:00:00', tickets_total: 10, tickets_sold: 10, waitlist: false)
ed_2 = EventDate.create( event_id: package_7.id, time_begin: '2015-06-05 10:00:00', time_end: '2015-06-05 12:00:00', tickets_total: 10, tickets_sold: 0, waitlist: true)
ed_3 = EventDate.create( event_id: package_7.id, time_begin: '2015-06-09 12:00:00', time_end: '2015-06-09 17:00:00', tickets_total: 20, tickets_sold: 6, waitlist: false)
ed_4 = EventDate.create( event_id: package_7.id, time_begin: '2015-10-09 12:00:00', time_end: '2015-10-09 17:00:00', tickets_total: 15, tickets_sold: 0, waitlist: true)
package_7.event_items << [ei_8]
package_7.event_dates << [ed_1, ed_2, ed_3]

puts 'CREATED PACKAGE: ' << package_1.title

# Waitlist
pack_1_waitlist = Waitlist.create(event_id: package_1.id, event_date_id: ed_2.id, limit: 3, total_users: 3)
pack_1_waitlist.users << [user_participant_1, user_participant_2, user_participant_3]
pack_1_waitlist_2 = Waitlist.create(event_id: package_1.id, event_date_id: ed_4.id, limit: 15, total_users: 1)
pack_1_waitlist_2.users << [user_participant_3, user]
