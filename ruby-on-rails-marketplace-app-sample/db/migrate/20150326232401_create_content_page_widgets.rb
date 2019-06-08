class CreateContentPageWidgets < ActiveRecord::Migration
  def change
    create_table :content_page_widgets do |t|
    	t.belongs_to :page
    	
      t.integer :widget_id
      t.string :widget_type
    	
      t.integer :row
    	t.integer :column
    	t.integer :span
      t.timestamps
    end
  end
end
