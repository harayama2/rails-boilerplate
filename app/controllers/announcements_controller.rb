class AnnouncementsController < ApplicationController
  before_action :mark_as_read, if: :user_signed_in?

  def index
    @pagy, @announcements = pagy(Announcement.order(published_at: :desc), size: 0)
  end

  private

  def mark_as_read
    current_user.update(announcements_read_at: Time.current)
  end
end
