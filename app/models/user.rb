class User < ActiveRecord::Base

  has_many  :user_waitlists, dependent: :destroy
  has_many  :waitlists, through: :user_waitlists
  has_many  :payments
  
  enum role: {participant:0, host:32, admin:64}
  after_initialize :set_default_role, if: :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :password, presence: true, confirmation: true, if: :password_required?
  validates :password, length: { within: Devise.password_length, allow_blank: true}
  validates :email, presence: true
  validates :email, format: {with: Devise.email_regexp, allow_blank: true},
            uniqueness: true, if: :email_changed?

  def may_assign_roles?
    admin?
  end

  def promote_to_host
    update_attribute(:role, :host) if self.participant?
  end

  def get_name_or_email
    name.nil? || name.blank? ? email : name
  end

  protected
  
  def set_default_role
    self.role ||= :participant
  end         
end
