class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :atts, dependent: :destroy
  has_many :exclusions, dependent: :destroy
  has_many :notes, dependent: :destroy  
  has_many :preferences, dependent: :destroy
  has_many :teas, dependent: :destroy
  has_many :wishlists, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: {minimum: 4, maximum: 20}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  strip_attributes
end
