class TeaType < ActiveRecord::Base
  	belongs_to :user
  	validates :name, presence: true
  	strip_attributes
end
