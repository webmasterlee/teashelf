class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :preferences
  validates :username, presence: true, uniqueness: true, length: {maximum: 20}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  strip_attributes
end
