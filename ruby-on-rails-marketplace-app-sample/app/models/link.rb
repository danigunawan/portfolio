class Link < ActiveRecord::Base
	belongs_to :site

	belongs_to :redirect_to,
		class_name: 'Link'

	has_one :redirect_from,
		class_name: 'Link',
		foreign_key: 'redirect_to_id'
end
