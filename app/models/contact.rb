class Contact

  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :subject, :message

  validates :name, presence: true, length: {maximum: 30}
  validates :subject, presence: true, length: {maximum: 30}
  validates :message, presence: true, length: {maximum: 1000}

end