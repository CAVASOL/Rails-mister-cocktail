class User < ApplicationRecord
  acts_as_favoritor

  has_many :cockatils, dependent: :destroy
  has_many :reviews
  has_many :ingredients

  validates :name, presence: true, length: { in: 2..26 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end
