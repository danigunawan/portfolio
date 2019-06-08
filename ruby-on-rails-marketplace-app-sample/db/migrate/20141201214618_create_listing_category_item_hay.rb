class CreateListingCategoryItemHay < ActiveRecord::Migration
  def change
    create_table :listing_category_item_hay do |t|	
    	# Meta references to the model owners.
    	t.belongs_to :listing_item_dispatcher

      t.belongs_to :hay_class
      t.belongs_to :hay_type
      t.belongs_to :hay_size
      t.belongs_to :binding_type
      t.boolean :fertilized, default: false

      t.float :weight
      t.belongs_to :weight_unit
    
      t.belongs_to :cutting_number

      t.date :harvest_date

      t.boolean :shipping, default: false

      t.integer :quantity
      t.belongs_to :quantity_unit

      t.text :description

      t.belongs_to :pricing_term
      t.belongs_to :pricing_unit

      t.timestamps
    end

    create_table :listing_category_item_hay_queries do |t|
      t.string :hash_key
      t.string :version
      t.belongs_to :parent_query

      t.belongs_to :hay_class
      t.belongs_to :hay_type
      t.belongs_to :hay_size
      t.belongs_to :binding_type
      t.boolean :fertilized

      t.float :weight_min
      t.float :weight_max
      t.belongs_to :weight_unit
    
      t.belongs_to :cutting_number

      t.date :harvest_date_min
      t.date :harvest_date_max

      t.boolean :shipping

      t.integer :quantity_min
      t.integer :quantity_max
      t.belongs_to :quantity_unit

      t.belongs_to :pricing_term
      t.belongs_to :pricing_unit

      t.timestamps
    end

    create_table :item_hay_meta_hay_classes do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :item_hay_meta_hay_types do |t|
      t.belongs_to :hay_class
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :item_hay_meta_hay_sizes do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end
  
    create_table :item_hay_meta_binding_types do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end
  
    create_table :item_hay_meta_weight_units do |t|
      t.string :name
      t.string :short_name
      t.boolean :published
      t.timestamps
    end
  
    create_table :item_hay_meta_cutting_numbers do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :item_hay_meta_quantity_units do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end
  
    create_table :item_hay_meta_pricing_terms do |t|
      t.string :name
      t.boolean :published
      t.boolean :disable_price
      t.timestamps
    end

    create_table :item_hay_meta_pricing_units do |t|
      t.string :name
      t.string :short_name
      t.boolean :published
      t.timestamps
    end
  end
end
