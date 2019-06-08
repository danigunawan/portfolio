class PhotoAssignment < ActiveRecord::Base
  belongs_to :assignable, polymorphic: true
  belongs_to :photo
end
