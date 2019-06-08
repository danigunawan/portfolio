class AddCateogryToContentWidgetSlider < ActiveRecord::Migration
  def change
    add_reference :content_widget_sliders, :category1, index: true
    add_reference :content_widget_sliders, :category2, index: true
    add_column :content_widget_sliders, :category1_classifier, :string
    add_column :content_widget_sliders, :category2_classifier, :string
  end
end
