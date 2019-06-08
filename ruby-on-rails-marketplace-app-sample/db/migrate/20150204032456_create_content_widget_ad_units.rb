class CreateContentWidgetAdUnits < ActiveRecord::Migration
  def change
    create_table :content_widget_ad_units do |t|
    	t.belongs_to :site
    	t.belongs_to :page
    	t.belongs_to :ad_zone
      t.timestamps
    end
  end
end
