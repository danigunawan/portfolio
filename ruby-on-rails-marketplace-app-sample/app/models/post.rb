class Post < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: [:slugged, :history]

	acts_as_paranoid

	is_impressionable :counter_cache => true, :column_name => :views

	acts_as_commentable

	belongs_to :site
	belongs_to :user

	has_many :photo_assignments, :as => :assignable
	has_many :photos, :through => :photo_assignments
end
