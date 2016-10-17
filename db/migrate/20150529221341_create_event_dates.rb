class CreateEventDates < ActiveRecord::Migration
  def change
    create_table :event_dates do |t|
    	t.references  :event, null: false, index: true
      t.datetime    :time_begin, null:false 
      t.datetime    :time_end, null:false 
      t.integer     :tickets_total, null:false, default: 0
      t.integer     :tickets_sold
      t.boolean     :waitlist, default: false
      t.timestamps null: false
    end
  end
end
