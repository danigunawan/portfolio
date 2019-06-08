class AddSnippetToContentWidgetAdUnits < ActiveRecord::Migration
  def change
    add_column :content_widget_ad_units, :snippet, :text
  end
end
