class Att < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :teas
  validates :name, presence: true
  strip_attributes
end
