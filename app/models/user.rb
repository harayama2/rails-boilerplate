class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users

  has_one_attached :avatar

  validates :first_name, :last_name, presence: true
end
