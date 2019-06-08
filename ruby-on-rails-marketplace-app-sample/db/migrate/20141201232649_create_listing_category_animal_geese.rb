class CreateListingCategoryAnimalGeese < ActiveRecord::Migration
  def change
    create_table :listing_category_animal_geese do |t|
    	# Meta references to the model owners.
    	t.belongs_to :listing_item_dispatcher

      t.belongs_to :breed
      t.belongs_to :color
      t.belongs_to :gender
      t.belongs_to :status
     
      t.float :weight
      t.belongs_to :weight_unit

      t.date :date_of_birth
      t.boolean :registered
      t.integer :quantity

      t.text :description

      t.belongs_to :pricing_term
      t.belongs_to :pricing_unit

      t.timestamps
    end

    create_table :listing_category_animal_geese_queries do |t|
      t.string :hash_key
      t.string :version
      t.belongs_to :parent_query

      t.belongs_to :breed
      t.belongs_to :color
      t.belongs_to :gender
      t.belongs_to :status
     
      t.float :weight_min
      t.float :weight_max
      t.belongs_to :weight_unit

      t.date :date_of_birth_min
      t.date :date_of_birth_max

      t.boolean :registered

      t.integer :quantity_min
      t.integer :quantity_max

      t.belongs_to :pricing_term
      t.belongs_to :pricing_unit

      t.timestamps
    end
    
    create_table :animal_geese_meta_breeds do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_geese_meta_colors do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_geese_meta_genders do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_geese_meta_statuses do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_geese_meta_weight_units do |t|
      t.string :name
      t.string :short_name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_geese_meta_pricing_terms do |t|
      t.string :name
      t.boolean :published
      t.boolean :disable_price
      t.timestamps
    end

    create_table :animal_geese_meta_pricing_units do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end
  end
end
