class FacebookPolicy < Policy

  def first_name
    split_name.first
  end

  def last_name
    split_name.last
  end

  def name
    @page['name'] || @auth.info.name
  end

  def email
    return @auth.info.email
  end

  def uid
    @page['id'] || super
  end

  def username
    @page['id'] || @auth.info.nickname || @auth.extra.raw_info.id
  end

  def image_url
    "https://graph.facebook.com/#{ username }/picture?type=large"
  end

  def oauth_token
    @page['access_token'] || (@channel ? @channel.oauth_token : nil) || super
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
    super + client.get_connections('me', 'accounts').select { |i| i["perms"].include? "ADMINISTER" }.map { |i| FacebookPolicy.new(@auth, i) }
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
    if (post.post_media.active_only.limit(1).first)
      # Load the default album id for the respective account.
      # @album = client.get_object("#{ @channel.oauth_uid }/albums").select { |i| i["name"] == "Timeline Photos" }.sort_by { |i| i["created_time"] }.first
      # @album ||= client.put_object(@channel.oauth_uid, 'albums', { name: "Timeline Photos" })

      # Post media as the feed item.
      post.post_media.active_only.limit(1).each do |post_media|
        # client.put_picture(post_media.url, { message: post.body }, @album['id']) if !post_media.video
        client.put_picture(post_media.url, { message: post.body }) if !post_media.video
        client.put_video(post_media.url, { message: post.body }) if post_media.video
      end
    else
      if !post.web_link
        client.put_connections('me', 'feed', message: post.body)
      else
        client.put_connections('me', 'feed', message: post.body, link: post.web_link.url)
      end
    end

    true
  end

  def client
    @client ||= Koala::Facebook::API.new(oauth_token, ENV["FACEBOOK_SECRET"])
  end
end
