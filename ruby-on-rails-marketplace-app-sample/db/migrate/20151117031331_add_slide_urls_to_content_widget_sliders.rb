class AddSlideUrlsToContentWidgetSliders < ActiveRecord::Migration
  def change
    add_column :content_widget_sliders, :slide_1_image_url, :string
    add_column :content_widget_sliders, :slide_2_image_url, :string
    add_column :content_widget_sliders, :slide_3_image_url, :string
  end
end
