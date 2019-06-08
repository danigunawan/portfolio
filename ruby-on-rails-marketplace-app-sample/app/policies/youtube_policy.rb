class YoutubePolicy < Policy

  def first_name
    @auth.info.first_name || split_name.first
  end

  def last_name
    @auth.info.last_name || split_name.last
  end

  def name
    @auth.info.name
  end

  def email
    return @auth.info.email
  end

  def uid
    super
  end

  def username
    @auth.info.name || @auth.extra.raw_info.sub
  end

  def image_url
    @auth.info.image
  end

  def oauth_token
    (@channel ? @channel.oauth_token : nil) || super
  end

  def oauth_refresh_token
    (@channel ? @channel.oauth_refresh_token : nil) || super
  end

  def oauth_expires
    Time.at(@auth.credentials.expires_at) if @auth.credentials && @auth.credentials.expires_at
  end

  def oauth_secret
    nil
  end

  def create_callback account
    # Place any methods you want to trigger on Facebook OAuth creation here.
  end

  def refresh_callback account
    # Place any methods you want to trigger on subsequent Facebook OAuth logins here.
  end

  def pages
    super
  end

  # Create Post Helper
  #
  # *** This should only be called upon by the channel ***
  #
  # This is a part of the post context and information flow for publishing
  # post -> channel_post_assignments -> channel -> **policy = published**
  #
  def publish(post)
    # if post.post_media.active_only.length <= 1
    #   @album = client.get_object("#{ @channel.oauth_uid }/albums").select { |i| i["name"] == "Timeline Photos" }.sort_by { |i| i["created_time"] }.first
    # else
    #   @album = client.put_object(@channel.oauth_uid, 'albums', { name: "Photos" })
    # end

    # With facebook media is restricted to one photo or video at a time to the network.
    # However, we can still post multiple photos to an album, then post the album update as a feed item.

    # Upload all media to facebook.
    # if (post.post_media.active_only.limit(1).first)
    #   # Load the default album id for the respective account.
    #   @album = client.get_object("#{ @channel.oauth_uid }/albums").select { |i| i["name"] == "Timeline Photos" }.sort_by { |i| i["created_time"] }.first

    #   # Post media as the feed item.
    #   post.post_media.active_only.limit(1).each do |post_media|
    #     client.put_picture(post_media.url, { message: post.body }, @album['id']) if !post_media.video
    #     client.put_video(post_media.url, { message: post.body }) if post_media.video
    #   end
    # else
    #   if !post.web_link
    #     client.put_connections('me', 'feed', message: post.body)
    #   else
    #     client.put_connections('me', 'feed', message: post.body, link: post.web_link.url)
    #   end
    # end

    # Post the first video.
    post.post_media.active_only.limit(1).each do |post_media|
      client.upload_video(post_media.url, {title: post.body, description: post.body, privacy_status: "public"}) if post_media.video
    end

    true
  end

  def client
    @client ||= Yt::Account.new(refresh_token: oauth_refresh_token)
  end
end