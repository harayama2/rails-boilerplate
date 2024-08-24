class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :role, presence: true
end
