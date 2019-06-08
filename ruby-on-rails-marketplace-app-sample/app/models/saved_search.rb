class SavedSearch < ActiveRecord::Base
	acts_as_paranoid

  belongs_to :user
  belongs_to :search

	def state_path
		read_attribute(:state_path) || search.state_path if search
	end
end
