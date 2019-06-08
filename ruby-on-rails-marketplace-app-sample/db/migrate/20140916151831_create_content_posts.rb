class CreateContentPosts < ActiveRecord::Migration
  def change
    create_table :content_posts do |t|

      # Mapping to the current_site instance.
      t.belongs_to :site
      
      t.timestamps
    end
  end
end
