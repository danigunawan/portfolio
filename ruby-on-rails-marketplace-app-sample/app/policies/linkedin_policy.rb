class LinkedinPolicy < Policy

  def first_name
    @auth.info.first_name
  end

  def last_name
    @auth.info.last_name
  end

  def name
    @page['name'] || (first_name + ' ' + last_name)
  end

  def email
    @auth.info.email.downcase
  end

  def uid
    @page['id'] || super
  end

  def username
    @auth.info.urls.public_profile
  end

  def image_url
    @page['logo_url'] || @auth.info.image
  end

  def oauth_token
    (@channel ? @channel.oauth_token : nil) || super
  end

  def oauth_expires
    nil
  end

  def oauth_secret
    (@channel ? @channel.oauth_secret : nil) || super
  end

  def create_callback account
    # Place any methods you want to trigger on LinkedIn OAuth creation here.
  end

  def refresh_callback account
    # Place any methods you want to trigger on LinkedIn OAuth creation here.
  end

  def pages
    super + client.company({is_admin:'true'}).all.map { |i| LinkedinPolicy.new(@auth, client.company({id:i.id,fields:[:id,:name,:logo_url]})) }
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
    #   client.put_connections('me', 'feed', message: post.body)
    # end
    # https://www.linkedin.com/pulse/how-use-your-whole-brain-generate-ideas-vishal-kataria?trk=hp-feed-article-title-like
    if !post.web_link
      share_body = { content: { description: post.body } }
      # TODO: Add image as weblink to post like hootesuite.
      # i.e. Brute force image sharing.
    else
      share_body = { content: { description: post.body, :'submitted-url' => post.web_link.url, :'submitted-image-url' => post.web_link.image } }
    end

    if !@channel.page
      client.add_share(share)
    else
      # TODO: NEEDS PRODUCTION TESTING
      client.add_company_share(@channel.oauth_uid, share)
    end

    true
  end

  def client
    return @client if @client
    @client = LinkedIn::Client.new(ENV['LINKEDIN_ID'], ENV['LINKEDIN_SECRET'])
    @client.authorize_from_access(oauth_token, oauth_secret)
    @client
  end
end
