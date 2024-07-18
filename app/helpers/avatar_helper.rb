module AvatarHelper
  def avatar_url_for(user, options = {})
    size = options[:size] || 48
    default_image = options[:default] || "mp"

    if user.avatar.attached?
      user.avatar.variant(resize_to_fill: [size, size])
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{size}&default=#{default_image}"
    end
  end
end
