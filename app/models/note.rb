class Note < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  strip_attributes
end
