class CreateSystemSites < ActiveRecord::Migration
  def change
    create_table :system_sites do |t|
    	
    	t.string :host
        
        t.boolean :active, default: false
    	t.boolean :claimed, default: false

    	t.belongs_to :theme
    	t.belongs_to :default_seo_setting

        t.string :delete_hash
        t.string :edit_hash
    	
    	t.timestamps
    end
  end
end
