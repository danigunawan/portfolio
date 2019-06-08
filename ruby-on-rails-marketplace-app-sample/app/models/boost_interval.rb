class BoostInterval < ActiveRecord::Base
	belongs_to :site
	has_many :listings
end
