class AddLogoImageUrlToSystemSites < ActiveRecord::Migration
  def change
    add_column :system_sites, :logo_image_url, :string
  end
end
