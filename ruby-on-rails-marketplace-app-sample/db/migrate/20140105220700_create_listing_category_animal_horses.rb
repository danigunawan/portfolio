class CreateListingCategoryAnimalHorses < ActiveRecord::Migration
  def change
    create_table :listing_category_animal_horses do |t|
      # Meta references to the model owners.
      t.belongs_to :listing_item_dispatcher

      t.belongs_to :breed
      t.belongs_to :color
      t.belongs_to :gender
      t.string :name
      t.belongs_to :status

      t.float :height
      t.belongs_to :height_unit
      
      t.float :weight
      t.belongs_to :weight_unit
      
      t.date :date_of_birth
      t.boolean :registered
      t.belongs_to :temperament

      t.text :description

      t.belongs_to :pricing_term
      t.belongs_to :pricing_unit

      t.timestamps
    end

    create_table :listing_category_animal_horse_queries do |t|
      t.string :hash_key
      t.string :version
      t.belongs_to :parent_query

      t.belongs_to :breed
      t.belongs_to :color
      t.belongs_to :gender
      t.belongs_to :status

      t.float :height_min
      t.float :height_max
      t.belongs_to :height_unit
      
      t.float :weight_min
      t.float :weight_max
      t.belongs_to :weight_unit
      
      t.date :date_of_birth_min
      t.date :date_of_birth_max
      t.boolean :registered
      t.belongs_to :temperament

      t.belongs_to :discipline

      t.belongs_to :pricing_term
      t.belongs_to :pricing_unit

      t.timestamps
    end

    create_table :animal_horse_meta_breeds do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_horse_meta_colors do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_horse_meta_genders do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_horse_meta_statuses do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_horse_meta_height_units do |t|
      t.string :name
      t.string :short_name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_horse_meta_weight_units do |t|
      t.string :name
      t.string :short_name
      t.boolean :published
      t.timestamps
    end

    create_table :animal_horse_meta_temperaments do |t|
      t.string :name
      t.integer :level
      t.boolean :published
      t.timestamps
    end

    create_table :animal_horse_meta_disciplines do |t|
      t.boolean :published
      t.string :name
      t.timestamps
    end
 
    create_table :animal_horse_meta_disciplines_listing_category_animal_horses, id: false do |t|
      t.belongs_to :discipline
      t.belongs_to :horse
    end

    create_table :animal_horse_meta_pricing_terms do |t|
      t.string :name
      t.boolean :published
      t.boolean :disable_price
      t.timestamps
    end

    create_table :animal_horse_meta_pricing_units do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end
  end
end
