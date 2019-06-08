class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
			t.belongs_to :site
      t.string :title
      t.text :body
      t.belongs_to :user

      t.timestamps null: false
    end

		create_table :posts_tags, id: false do |t|
			t.integer :post_id
			t.integer :tag_id
		end
  end
end
