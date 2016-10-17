class Waitlist < ActiveRecord::Base
  belongs_to  :event
  belongs_to  :event_date
  has_many    :user_waitlists, dependent: :destroy
  has_many    :users, through: :user_waitlists

  DEFAULT_LIMIT = 15

  before_validation :set_event_id, on: [ :create, :update ]

  validates :event_id, :event_date_id, :limit, presence: true

  attr_accessor :add_user, :remove_user
    
  def set_default_limit
    update_attribute(:limit, DEFAULT_LIMIT)
  end

  def update_limit(limit)
    update_attribute(:limit, limit)
  end

  def full_waitlist?
    limit <= total_users
  end

  def add_user_to_waitlist(emails)
    found_users = User.where(email: emails.split(',').collect(&:strip))
    unless found_users.empty?
      found_users.each do |user|
        unless users.exists?(user.id)
          users << user 
          update_attribute(:total_users, total_users+1)
        end
      end
    end
  end

  def remove_user_from_waitlist(user) 
    user = User.find(user)
    if users.exists?(user) 
      users.delete(user)
      update_attribute(:total_users, total_users-1) 
    end
  end

  def user_waitlisted?(user)
    users.exists?(user.id)
  end

  private
  def set_event_id
    self.event_id = event_date.event.id unless event_date_id.nil?
  end
end
