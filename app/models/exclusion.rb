class Exclusion < ActiveRecord::Base
	belongs_to :user
	validates :attr, presence: true
	validates :value, presence: true
	validates :user_id, presence: true
	strip_attributes
end
