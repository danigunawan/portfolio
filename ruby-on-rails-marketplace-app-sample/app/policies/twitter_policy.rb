class TwitterPolicy < Policy

  def first_name
    split_name.first
  end

  def last_name
    split_name.last
  end

  def name
    @auth.info.name
  end

  def email
    nil
  end

  def username
    @auth.info.nickname
  end

  def image_url
    @auth.extra.raw_info.profile_image_url_https.gsub('normal','bigger')
  end

  def oauth_expires
    nil
  end

  def oauth_secret
    @auth.credentials.secret
  end

  def create_callback account
    # Place any methods you want to trigger on Twitter OAuth creation here.
  end

  def refresh_callback account
    # Place any methods you want to trigger on Twitter OAuth creation here.
  end

  # Create Post Helper
  #
  # *** This should only be called upon by the channel ***
  #
  # This is a part of the post context and information flow for publishing
  # post -> channel_post_assignments -> channel -> **policy = published**
  #
  def publish(post)
    # Upload all media to twitter.
    media_ids = post.post_media.active_only.limit(4).map do |post_media|
      Thread.new do
        client.upload(open(post_media.url))
      end if !post_media.video
    end.map(&:value)

    # TODO: BUG HERE  NO WEB LINKS
    client.update("#{post.body} #{ post.web_link && !post.body.include?(post.web_link) ? post.web_link.url : '' }", :media_ids => media_ids.join(','))

    true
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_ID"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = @channel.oauth_token
      config.access_token_secret = @channel.oauth_secret
    end
  end
end
