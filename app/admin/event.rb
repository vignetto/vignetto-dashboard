ActiveAdmin.register Event do
  menu label: "Events/Packages"
  permit_params do
    params = [
    	:user_id,
      :private_event,
      :publish,
      :package,
      :title,
      :short_description,
      :description,
      :ticket_price,
      :position,
      :created_at,
      :updated_at,
      :avatar,
      :preview,
      :banner,
      event_dates_attributes: [:id, :event_id, :_destroy, :time_begin, :time_end, :tickets_total, :tickets_sold, :waitlist],
      event_items_attributes: [:id, :event_id, :_destroy, :position, :name, :description, :itinerary_item, :itinerary_description, :itinerary_begin, :itinerary_end, :show_map, :address, :city, :state, :zipcode, :latitude, :longitude, :upload]]
  end

  scope "Events", :if => proc { current_user.admin? } do |events|
    events.where(package: false)
  end
  scope "Packages", :if => proc { current_user.admin? } do |packages|
    packages.where(package: true)
  end

  after_save do |event|
    waitlists = event.generate_new_waitlists
    flash[:notice] = "#{waitlists} new #{'waitlist'.pluralize(waitlists)} created for this event." unless waitlists == 0
  end

  index do
    if current_user.admin?
      selectable_column
    end
    id_column if current_user.admin?
    column :title
    column "Tickets" do |e|
      "#{e.get_tickets_sold}/#{e.get_total_tickets}"
    end
    column :package
    column :publish
    column("Waitlist Only?") {|e| e.waitlist_only? ? status_tag("YES") : status_tag("NO")}
    column :position
    column("Ticket Price") {|e| status_tag "#{number_to_currency(e.ticket_price)}", :ok}
    column :updated_at
    actions
  end

  filter :title
  filter :private_event

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Event Details" do
      f.input :title
      f.input :short_description
      f.input :description
      f.input :ticket_price
      f.input :position
      f.input :publish
      f.input :package
      f.input :private_event
    end
    f.inputs "Event Primary Images" do
      f.inputs "Avatar Image", :multipart => true do
        f.input :avatar, hint: image_tag(f.object.avatar.url(:thumb))
      end
      f.inputs "Preview Image", :multipart => true do
        f.input :preview, hint: image_tag(f.object.preview.url(:thumb))
      end
      f.inputs "Banner Image", :multipart => true do
        f.input :banner, hint: image_tag(f.object.banner.url(:thumb))
      end
    end
    f.inputs "Event Items" do
      f.has_many :event_items, new_record: "New Event Item", heading: false, sortable: :position, sortable_start: 1, html: { multipart: true }, allow_destroy: true do |dt|
        dt.input :position, hint: "Order of item when displayed on details page."
        dt.input :name
        dt.input :description
        dt.input :upload, label: "Picture"
        dt.input :itinerary_item, hint: "If checked, will be generated in the itinerary module. Start and end date required below."
        dt.input :itinerary_begin, label: "(Itinerary) Start Time", as: :string, input_html: {class: "hasDatetimePicker"}
        dt.input :itinerary_end, label: "(Itinerary) End Time", as: :string, input_html: {class: "hasDatetimePicker"}
        dt.input :itinerary_description, label: "(Itinerary) Description"
        dt.input :show_map
        dt.input :address
        dt.input :city
        dt.input :state
        dt.input :zipcode
        dt.input :latitude
        dt.input :longitude
      end
    end
    f.inputs "Event Dates/Tickets" do
      f.has_many :event_dates, new_record: "New Event Date", heading: false, allow_destroy: true do |dt|
        dt.input :time_begin, label: "Start Time", as: :string, input_html: {class: "hasDatetimePicker"}
        dt.input :time_end, label: "End Time", as: :string, input_html: {class: "hasDatetimePicker"}
        dt.input :tickets_total, label: "Total Tickets"
        dt.input :tickets_sold, label: "Tickets Sold"
        dt.input :waitlist, hint: "If checked, purchases are disabled and waitlist enabled"
      end
    end
    f.actions
  end

  show do
    tabs do
      tab 'Metadata' do
        attributes_table do
          row :id
          row :title
          row("event host") {|e| link_to User.find(e.user_id).name, admin_user_path(e.user_id)}
          row("type") {|e| e.package ? status_tag("Package", :red) : status_tag("Event", :red) }
          row("private") {|e| e.private_event ? status_tag("YES") : status_tag("NO") }
          row("publish") {|e| e.publish ? status_tag("YES") : status_tag("NO") }
          row("ticket price") {|e| status_tag number_to_currency(e.ticket_price), :ok}
          row :short_description
          row :description
          row :position
          row('avatar image') {|e| image_tag e.avatar.url(:badge) unless e.avatar_file_name.nil?  }
          row('preview image') {|e| image_tag e.preview.url(:tile) unless e.preview_file_name.nil?  }
          row('banner image') {|e| image_tag e.banner.url(:header) unless e.banner_file_name.nil?  }
          row :created_at
          row :updated_at
        end
      end
      tab 'Main Content' do
        event.event_items.order(position: :asc).each do |item|
          panel "#{item.name}" do
            attributes_table_for item  do
              row('position') {status_tag "#{item.position}", :red}
              row('description', item.description)
              row('picture') {image_tag item.upload.url(:thumb)} unless item.upload_file_name.nil?
              row('address') {"#{item.address}, #{item.city}, #{item.state} #{item.zipcode}"} unless item.address.nil? || item.address.blank?
              row('show map') {status_tag "Show Map", :red } if item.show_map
              row('map') {"longitude: #{item.longitude},  latitude: #{item.latitude}"} if item.show_map
              row('itinerary') {"#{item.itinerary_begin.strftime('%l:%M %p')} - #{item.itinerary_end.strftime('%l:%M %p')} .............. #{item.itinerary_description}"} if item.itinerary_item && item.itinerary_begin && item.itinerary_end
            end
          end
        end
      end
      tab 'Dates\Tickets Section' do
        panel "Dates ( #{event.event_dates.count} )" do
          table_for event.event_dates.order(time_begin: :asc) do
            column('Weekday') { |d| d.time_begin.strftime("%A") }
            column('Month') { |d| status_tag d.time_begin.strftime("%b"), :yes  }
            column('Day') { |d| status_tag d.time_begin.strftime("%d"), :yes  }
            column('Total Tickets', :tickets_total)
            column :tickets_sold
            column("Event") {|d| "#{number_to_currency(event.ticket_price)} - #{distance_of_time_in_words(d.time_begin, d.time_end)}".gsub('about', '') }
            column("Tickets") do |d|
              if d.waitlist
                status_tag "WAITLIST", :red
              else
                status_tag( (d.tickets_sold_out? ? "SOLD OUT" : "GET TICKETS"), :red)
              end
            end
          end
        end
      end
      tab 'Daily Itinerary Section' do
        ei_list = event.event_items.where(itinerary_item: true).order(position: :asc)
        panel "Itinerary Items ( #{ei_list.count} )" do
          table_for ei_list do
            column('Begin') { |d| d.itinerary_begin.strftime("%I%p").downcase.gsub('m', '') if d.itinerary_begin}
            column('End') { |d| d.itinerary_end.strftime("%I%p").downcase.gsub('m', '') if d.itinerary_end}
            column('Desciption') { |d| d.itinerary_description if d.itinerary_description}
          end
        end
      end
      tab 'Waitlists' do
        panel "Waitlists ( #{event.waitlists.size} )" do
          table_for event.waitlists do
            column('id'){|w| link_to w.id, admin_waitlist_path(w) }
            column('Event Date') {|w| w.event_date.get_event_duration_format}
            column :limit
            column :total_users
            column('Active') {|w| w.active ? (status_tag 'ACTIVE', :green) : (status_tag 'NO')}
            column('Full') {|w| w.full_waitlist? ? (status_tag 'FULL', :red) : (status_tag 'NO')}
            column :created_at
            column :updated_at
            column('actions'){|w| link_to "Edit", edit_admin_waitlist_path(w) }
            column(''){|w| link_to "View", admin_waitlist_path(w) }
          end
        end
      end
    end
  end

  before_create do |event|
    event.user = current_user
  end

  controller do
    def destroy
      if resource.all_waitlists_empty?
        super do |format|
          redirect_to collection_url, notice: "Event was successfully deleted." and return if resource.valid?
        end
      else
        redirect_to collection_url, alert: "Event cannot be deleted, some waitlists are not empty." and return if resource.valid?
      end
    end
  end

  sidebar :help do
    div do
      "Waitlist only event or package:"
    end
    ol do 
      li "create only one Event Date for event or package"
      li "make it a waitlist by checking waitlist checkbox"
    end
  end
end
