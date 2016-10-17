class Inquiry < ActiveRecord::Base
  enum request_type: { generic: 0, to_be_host: 10, private_event: 20 }

  validates :request_type, :first_name, :last_name, :email, :phone, presence: true, allow_blank: false
  validates :email, format: {with: Devise.email_regexp}
  validates :phone, length: { minimum: 10, maximum: 12 }

  scope :recent, ->(num) { order("id DESC").limit(num) }
end
