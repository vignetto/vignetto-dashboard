class Event < ActiveRecord::Base

  belongs_to :user
  has_many  :event_items, inverse_of: :event, dependent: :destroy
  has_many  :event_dates, inverse_of: :event, dependent: :destroy
  has_many  :waitlists, inverse_of: :event, dependent: :destroy
  has_many  :payments, inverse_of: :event

  validates :title, :short_description, :ticket_price, :user, presence: true

  accepts_nested_attributes_for :event_items, :event_dates, allow_destroy: true, reject_if: :all_blank

  scope :recent, ->(num) { order("id DESC").limit(num) }
  scope :published, -> { where("publish = ?", true) }
  scope :unpublished, -> { where("publish = ?", false) }

  has_attached_file :avatar,
                  :styles         => { badge: "70x70#", thumb: "50x50#"},
                  :default_url    => "/images/attachments/:style/avatar_missing.png",
                  :storage        => (ENV['DEV_USE_LOCAL'] ? :filesystem : :s3),
                  :s3_credentials => Rails.application.secrets.aws,
                  :s3_protocol    => 'https',
                  :s3_host_name   => "#{['s3', Rails.application.secrets.aws['region']].compact.join('-')}.amazonaws.com",
                  :bucket         => Rails.application.secrets.aws[:bucket]


  has_attached_file :preview,
                  :styles         => { tile: "360x360>", thumb: "50x50>"},
                  :default_url    => "/images/attachments/:style/preview_missing.png",
                  :storage        => (ENV['DEV_USE_LOCAL'] ? :filesystem : :s3),
                  :s3_credentials => Rails.application.secrets.aws,
                  :s3_protocol    => 'https',
                  :s3_host_name   => "#{['s3', Rails.application.secrets.aws['region']].compact.join('-')}.amazonaws.com",
                  :bucket         => Rails.application.secrets.aws[:bucket]

  has_attached_file :banner,
                  :styles         => { header: "1140x354>", thumb: "114x35>"},
                  :default_url    => "/images/attachments/:style/banner_missing.png",
                  :storage        => (ENV['DEV_USE_LOCAL'] ? :filesystem : :s3),
                  :s3_credentials => Rails.application.secrets.aws,
                  :s3_protocol    => 'https',
                  :s3_host_name   => "#{['s3', Rails.application.secrets.aws['region']].compact.join('-')}.amazonaws.com",
                  :bucket         => Rails.application.secrets.aws[:bucket]

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :preview, content_type: /\Aimage\/.*\Z/

  def get_total_tickets
  	event_dates.any? ? event_dates.pluck(:tickets_total).inject(:+) : 0
  end

  def get_tickets_sold
  	event_dates.any? ? event_dates.pluck(:tickets_sold).inject(:+) : 0
  end

  def publish_event
    update_attribute(:publish, true)
  end

  def get_itinerary_list
    event_items.where(itinerary_item: true).order(itinerary_begin: :asc).inject([]) do |all, ei|
      final = if  ei.itinerary_begin && ei.itinerary_end && ei.itinerary_description
        str = ei.itinerary_begin.strftime("%I%p").downcase.gsub('m', '').gsub(/^0/, '')
        str_end = ei.itinerary_end.strftime("%I%p").downcase.gsub('m', '').gsub(/^0/, '') 
        space = 50 - str.bytesize - str_end.bytesize
        final = str + ' - ' + "#{str_end} " + '. '*(space/2) + " #{ei.itinerary_description}"
      else 
        nil
      end
      all << final
    end    
  end

  def generate_new_waitlists
    waitlisted_dates = event_dates.where(waitlist: true)
    w_count = 0
    unless waitlisted_dates.empty?
      waitlisted_dates.each do |wd|
        unless Waitlist.exists?(event_date_id: wd.id)
          waitlist = Waitlist.new(event_id: id, event_date_id: wd.id, limit: Waitlist::DEFAULT_LIMIT)
          w_count +=1 if waitlist.save
        end
      end
    end
    w_count
  end

  def all_waitlists_empty?
    unless waitlists.empty?
      waitlists.each{|w| return false if w.users.any?}
    end
    true
  end

  def get_stripe_ticket_price
    ticket_price * 100
  end

  def get_ticket_price_to_currency
    "$#{sprintf( "%0.02f", ticket_price)}"
  end

  def waitlist_only?
    event_dates.size == 1 && event_dates.first.waitlist
  end

  def get_geomap_lat_long
    event_items.where(show_map: true).where.not(latitude: nil, longitude: nil).inject([]) do |all, point|
      all << [point.name, point.latitude, point.longitude]
    end
  end

  def has_map?
    event_items.where(show_map: true).where.not(latitude: nil, longitude: nil).any?
  end

  def has_itinerary_items?
    event_items.where(itinerary_item: true).any? && !get_itinerary_list.compact.empty?
  end
end
