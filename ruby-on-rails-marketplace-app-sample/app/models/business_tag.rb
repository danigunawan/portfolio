class BusinessTag < ActiveRecord::Base
  extend FriendlyId
	friendly_id :name, use: [:slugged, :history]

  has_and_belongs_to_many :businesses
end
