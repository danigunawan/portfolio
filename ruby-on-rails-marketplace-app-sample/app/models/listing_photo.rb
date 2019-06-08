class ListingPhoto < ActiveRecord::Base
  belongs_to :listing
  belongs_to :photo
end
