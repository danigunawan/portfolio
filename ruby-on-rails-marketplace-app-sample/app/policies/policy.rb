class Policy

  def provider
    @auth.provider
  end

  def castChannelToAuth(channel)
    {
      uid: @channel.oauth_uid,
      provider: @channel.provider,
      username: @channel.username,
      info: {
        name: @channel.name
      },
      credentials: {
        token: @channel.oauth_token,
        refresh_token: @channel.oauth_refresh_token,
        expires_at: @channel.oauth_expires,
        secret: @channel.oauth_secret,
      }
    }
  end

  def is_page?
    @is_page ||= false

    @page ? @is_page : true
  end

  def initialize(auth, page={})
    @page = page
    if auth && auth.is_a?(Channel)
      @channel = auth
      @auth = castChannelToAuth(@channel)
    else
      @auth = auth
    end
  end

  def uid
    @auth.uid
  end

  def oauth_token
    @auth.credentials.token
  end

  def oauth_secret
    @auth.credentials.secret
  end

  def oauth_refresh_token
    @auth.credentials.refresh_token
  end

  def oauth_expires
    Time.at(@auth.credentials.expires_at)
  end

  def pages
    return [self]
  end

  # Create Post Helper
  #
  # *** This should only be called upon by the channel ***
  #
  # This is a part of the post context and information flow for publishing
  # post -> channel_post_assignments -> channel -> **policy = published**
  #
  def publish(post)
    # Return false for unposted and true for posted.
    false
  end

  private

    def split_name
      name = @auth.info.name
      if name.include?(" ")
        last_name  = name.split(" ").last
        first_name = name.split(" ")[0...-1].join(" ")
      else
        first_name = name
        last_name  = nil
      end
      [first_name, last_name]
    end
end
