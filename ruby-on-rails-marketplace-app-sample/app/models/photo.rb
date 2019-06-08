class Photo < ActiveRecord::Base

	before_validation :set_s3_key
	before_save :set_s3_key
	before_update :set_s3_key

	# acts_as_paranoid
	# after_destroy :delete_photo

	belongs_to :user
	belongs_to :site

	# Associations to the listing through order:
	has_many :listing_photos,
		dependent: :destroy

	has_many :photo_assignments,
		dependent: :destroy

	def bucket(subset=:original)
		S3_BUCKET.presigned_post(key: "#{ send(subset) }", success_action_status: '201', acl: 'public-read')
	end

	def original
		"#{ set_s3_key }/original.jpeg"
	end

	def large
		"#{ set_s3_key }/large.jpeg"
	end

	def medium
		"#{ set_s3_key }/medium.jpeg"
	end

	def small
		"#{ set_s3_key }/small.jpeg"
	end

	def square
		"#{ set_s3_key }/square.jpeg"
	end

	def poster
		"#{ set_s3_key }/poster.jpeg"
	end

	def url(subset=:original)
		"https://#{ ENV['AWS_S3_BUCKET'] }.s3.amazonaws.com/#{ send(subset) }"
	end

	def content_type(subset=:original)
		"image/jpeg"
	end

	private
		def set_s3_key
			write_attribute(:key, "#{ site.host }/photos/#{SecureRandom.uuid}") if !read_attribute(:key)
			read_attribute(:key)
		end

		def delete_photo
			S3_BUCKET.objects(prefix:key).batch_delete!
		end
end
