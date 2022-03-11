class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_favoritor

  has_many :cockatils
  validates :name, presence: true, length: { in: 2..26 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
