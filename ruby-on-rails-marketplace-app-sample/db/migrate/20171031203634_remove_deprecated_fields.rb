class RemoveDeprecatedFields < ActiveRecord::Migration
  def change
		remove_column :photos, :listing_reference_id
  end
end
