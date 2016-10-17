class UserWaitlist < ActiveRecord::Base
  belongs_to :user 
  belongs_to :waitlist 
end
