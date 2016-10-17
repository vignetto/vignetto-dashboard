class EventItem < ActiveRecord::Base

	belongs_to :event

  has_attached_file :upload,
                  :styles         =>    { :thumb => "100x100>", :preview => "250x250>"},
                  :default_url    =>    "/images/attachments/:style/upload_missing.png",
                  :storage        => (ENV['DEV_USE_LOCAL'] ? :filesystem : :s3),
                  :s3_credentials => Rails.application.secrets.aws,
                  :s3_protocol    => 'https',
                  :s3_host_name   => "#{['s3', Rails.application.secrets.aws['region']].compact.join('-')}.amazonaws.com",
                  :bucket         => Rails.application.secrets.aws[:bucket]

  validates_attachment_content_type :upload, content_type: /\Aimage\/.*\Z/

  geocoded_by :full_street_address   # can also be an IP address

  after_validation :geocode, if: ->(obj){ (obj.latitude.blank? or obj.longitude.blank?) and obj.address.present? and obj.address_changed? }

  def full_street_address
    [address, city, state, "USA", zipcode].compact.join(" ")
  end
end
