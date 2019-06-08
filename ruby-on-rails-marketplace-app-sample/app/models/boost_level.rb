class BoostLevel < ActiveRecord::Base
	belongs_to :site
	has_many :listings

	def priced_label
		label + (price && price > 0 ? " ($#{ price/100 }/Month)" : "")
	end
end
