class Favorite < ActiveRecord::Base
	acts_as_paranoid
	
  belongs_to :user
  belongs_to :listing
end
