class CreateContentWidgetTextAreas < ActiveRecord::Migration
  def change
    create_table :content_widget_text_areas do |t|
    	t.belongs_to :site
    	t.belongs_to :page
    	t.text :content
      t.timestamps
    end
  end
end
