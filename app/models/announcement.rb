class Announcement < ApplicationRecord
  KINDS = %w[new fix update]

  after_initialize :set_defaults

  validates :kind, :published_at, :title, :description, presence: true
  validates :kind, inclusion: {in: KINDS}

  def set_defaults
    self.kind ||= KINDS.first
    self.published_at ||= Time.current
  end
end
