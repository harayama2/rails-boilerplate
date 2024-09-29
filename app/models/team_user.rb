class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :role, presence: true
  validates :role, inclusion: { in: %w[admin member] }
end
