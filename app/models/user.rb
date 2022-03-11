class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_favoritor

  has_many :cockatils

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
