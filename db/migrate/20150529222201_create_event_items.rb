class CreateEventItems < ActiveRecord::Migration
  def change
    create_table :event_items do |t|
    	t.references  :event, null: false, index: true
      t.integer     :position, null: false, default: 0
      t.string      :name, null: false
      t.text        :description, null: false
      t.boolean     :itinerary_item, default: false
      t.string      :itinerary_description
      t.datetime    :itinerary_begin
      t.datetime    :itinerary_end
      t.boolean     :show_map, default: false
      t.string      :address
      t.string      :city
      t.string      :state
      t.integer     :zipcode
      t.float       :latitude
      t.float       :longitude
      t.timestamps null: false
    end
  end
end
