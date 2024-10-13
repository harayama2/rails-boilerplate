class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users

  has_one_attached :avatar

  validates :first_name, :last_name, presence: true

  def create_default_team
    return teams.first if teams.any?

    team = Team.new(name: "#{first_name} #{last_name}")
    # チームを作った人はオーナーにする
    team.owner = self
    # チームを作った人には管理者権限を持たせる
    team.team_users.new(user: self, role: "admin")
    team.save
    team
  end
end
