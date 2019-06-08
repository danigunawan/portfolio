class CreateContentWidgetSliders < ActiveRecord::Migration
  def change
    create_table :content_widget_sliders do |t|
    	t.belongs_to :site
    	t.belongs_to :page
    	t.timestamps
    end
  end
end
