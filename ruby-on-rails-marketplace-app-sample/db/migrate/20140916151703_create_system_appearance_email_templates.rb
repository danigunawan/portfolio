class CreateSystemAppearanceEmailTemplates < ActiveRecord::Migration
  def change
    create_table :system_appearance_email_templates do |t|

      # Mapping to the current_site instance.
      t.belongs_to :site
      
      t.timestamps
    end
  end
end
