class CreateContentWidgetRecommendedListings < ActiveRecord::Migration
  def change
    create_table :content_widget_recommended_listings do |t|
    	t.belongs_to :site
    	t.belongs_to :page
    	t.belongs_to :category
      t.timestamps
    end
  end
end
