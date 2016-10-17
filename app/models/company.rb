class Company < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true, allow_blank: false
end
