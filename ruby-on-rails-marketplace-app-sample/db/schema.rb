# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180706221228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "boost_intervals", force: :cascade do |t|
    t.integer  "term"
    t.string   "label"
    t.float    "discount"
    t.boolean  "active",     default: true
    t.integer  "site_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "boost_intervals", ["site_id"], name: "index_boost_intervals_on_site_id", using: :btree

  create_table "boost_levels", force: :cascade do |t|
    t.integer  "level"
    t.string   "label"
    t.float    "price"
    t.boolean  "active",     default: true
    t.integer  "site_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "boost_levels", ["site_id"], name: "index_boost_levels_on_site_id", using: :btree

  create_table "business_tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "business_tags_businesses", id: false, force: :cascade do |t|
    t.integer "business_id"
    t.integer "business_tag_id"
  end

  add_index "business_tags_businesses", ["business_id"], name: "index_business_tags_businesses_on_business_id", using: :btree
  add_index "business_tags_businesses", ["business_tag_id"], name: "index_business_tags_businesses_on_business_tag_id", using: :btree

  create_table "businesses", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.string   "safe_address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.datetime "edited_at"
    t.string   "youtube_url"
    t.string   "facebook_url"
    t.string   "website_url"
    t.string   "slug"
    t.text     "description"
    t.integer  "views",         default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "site_id"
    t.string   "name"
    t.boolean  "published"
    t.integer  "parent_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "promoted",                default: false
    t.integer  "price_unit_attribute_id"
    t.integer  "category_syndicate_id"
  end

  add_index "categories", ["category_syndicate_id"], name: "index_categories_on_category_syndicate_id", using: :btree
  add_index "categories", ["price_unit_attribute_id"], name: "index_categories_on_price_unit_attribute_id", using: :btree

  create_table "categories_listings", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "listing_id"
  end

  add_index "categories_listings", ["category_id"], name: "index_categories_listings_on_category_id", using: :btree

  create_table "category_attribute_values", force: :cascade do |t|
    t.string   "value"
    t.float    "float_value"
    t.float    "priority"
    t.boolean  "published",             default: true
    t.boolean  "boolean",               default: true
    t.integer  "category_attribute_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "category_attribute_values_listings", id: false, force: :cascade do |t|
    t.integer "listing_id"
    t.integer "category_attribute_value_id"
  end

  add_index "category_attribute_values_listings", ["category_attribute_value_id"], name: "category_attribute_value_listings_cat_val_ids", using: :btree
  add_index "category_attribute_values_listings", ["listing_id", "category_attribute_value_id"], name: "category_attribute_value_ids_listings_ids", using: :btree

  create_table "category_attributes", force: :cascade do |t|
    t.string   "name"
    t.text     "config"
    t.integer  "category_id"
    t.integer  "category_attribute_id"
    t.boolean  "published",             default: true
    t.boolean  "boolean",               default: false
    t.boolean  "restricted",            default: false
    t.float    "priority"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "required",              default: true
  end

  create_table "category_syndicates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "favorites", ["deleted_at"], name: "index_favorites_on_deleted_at", using: :btree
  add_index "favorites", ["listing_id"], name: "index_favorites_on_listing_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "links", force: :cascade do |t|
    t.integer  "site_id"
    t.string   "path"
    t.boolean  "indexed",          default: false
    t.datetime "lastmod"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "redirect_link_id"
  end

  add_index "links", ["redirect_link_id"], name: "index_links_on_redirect_link_id", using: :btree
  add_index "links", ["site_id"], name: "index_links_on_site_id", using: :btree

  create_table "listing_drafts", force: :cascade do |t|
    t.text     "draft"
    t.integer  "user_id"
    t.integer  "site_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ip_address"
    t.string   "location"
  end

  add_index "listing_drafts", ["listing_id"], name: "index_listing_drafts_on_listing_id", using: :btree
  add_index "listing_drafts", ["site_id"], name: "index_listing_drafts_on_site_id", using: :btree
  add_index "listing_drafts", ["user_id"], name: "index_listing_drafts_on_user_id", using: :btree

  create_table "listing_messages", force: :cascade do |t|
    t.integer  "listing_id"
    t.boolean  "sent",            default: false
    t.integer  "user_id"
    t.string   "from_ip_address"
    t.string   "from_email"
    t.string   "phone"
    t.string   "last_name"
    t.string   "first_name"
    t.text     "body"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
  end

  add_index "listing_messages", ["listing_id"], name: "index_listing_messages_on_listing_id", using: :btree
  add_index "listing_messages", ["user_id"], name: "index_listing_messages_on_user_id", using: :btree

  create_table "listing_photos", force: :cascade do |t|
    t.integer  "listing_id"
    t.integer  "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "listing_photos", ["listing_id"], name: "index_listing_photos_on_listing_id", using: :btree
  add_index "listing_photos", ["photo_id"], name: "index_listing_photos_on_photo_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "country_id"
    t.string   "youtube_url"
    t.float    "price"
    t.integer  "currency_id"
    t.boolean  "transportation_available"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.integer  "category_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "external",                 default: false
    t.string   "host"
    t.string   "external_source"
    t.boolean  "buyable",                  default: false
    t.text     "description"
    t.datetime "edited_at"
    t.string   "address"
    t.integer  "views",                    default: 0
    t.integer  "price_unit_id"
    t.datetime "activated_at"
    t.string   "safe_address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "boost_level_id"
    t.integer  "boost_interval_id"
    t.string   "boost_plan_id"
    t.string   "headline"
    t.datetime "deleted_at"
    t.datetime "expired_at"
    t.boolean  "billing_active",           default: true
    t.string   "migration_key"
    t.boolean  "active",                   default: true
  end

  add_index "listings", ["boost_interval_id"], name: "index_listings_on_boost_interval_id", using: :btree
  add_index "listings", ["boost_level_id"], name: "index_listings_on_boost_level_id", using: :btree
  add_index "listings", ["deleted_at"], name: "index_listings_on_deleted_at", using: :btree
  add_index "listings", ["price_unit_id"], name: "index_listings_on_price_unit_id", using: :btree
  add_index "listings", ["slug"], name: "index_listings_on_slug", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "photo_assignments", force: :cascade do |t|
    t.integer  "assignable_id"
    t.string   "assignable_type"
    t.integer  "photo_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "photo_assignments", ["assignable_id"], name: "index_photo_assignments_on_assignable_id", using: :btree
  add_index "photo_assignments", ["photo_id"], name: "index_photo_assignments_on_photo_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "key"
    t.string   "title"
    t.string   "description"
    t.boolean  "processed",   default: false
    t.integer  "site_id"
    t.datetime "deleted_at"
    t.boolean  "uploaded",    default: false
  end

  add_index "photos", ["deleted_at"], name: "index_photos_on_deleted_at", using: :btree
  add_index "photos", ["site_id"], name: "index_photos_on_site_id", using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "stripe_id"
    t.string   "name"
    t.string   "interval"
    t.integer  "amount"
    t.string   "currency"
    t.integer  "interval_count"
    t.integer  "trial_period_days"
    t.text     "metadata"
    t.boolean  "active",            default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "site_id"
    t.boolean  "recommended",       default: false
  end

  add_index "plans", ["site_id"], name: "index_plans_on_site_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "site_id"
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "featured_photo_url"
    t.integer  "views",              default: 0
    t.datetime "deleted_at"
    t.datetime "edited_at"
    t.boolean  "published",          default: false
    t.boolean  "declined",           default: false
    t.string   "slug"
    t.datetime "publish_at"
  end

  add_index "posts", ["deleted_at"], name: "index_posts_on_deleted_at", using: :btree

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  create_table "queries", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "results_count"
    t.datetime "datetime_results_count_last_updated"
    t.integer  "category_id"
    t.integer  "country_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.boolean  "has_photos"
    t.boolean  "has_videos"
    t.float    "price_min"
    t.float    "price_max"
    t.integer  "currency_id"
    t.boolean  "transportation_available"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "queries", ["results_count"], name: "index_queries_on_results_count", using: :btree
  add_index "queries", ["site_id"], name: "index_queries_on_site_id", using: :btree
  add_index "queries", ["slug"], name: "index_queries_on_slug", using: :btree

  create_table "saved_searches", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string   "state_url"
  end

  add_index "saved_searches", ["deleted_at"], name: "index_saved_searches_on_deleted_at", using: :btree
  add_index "saved_searches", ["search_id"], name: "index_saved_searches_on_search_id", using: :btree
  add_index "saved_searches", ["user_id"], name: "index_saved_searches_on_user_id", using: :btree

  create_table "searches", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "results_count"
    t.datetime "datetime_results_count_last_updated"
    t.integer  "category_id"
    t.float    "price_min"
    t.float    "price_max"
    t.string   "slug"
    t.string   "location"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.float    "distance"
    t.string   "keywords"
    t.datetime "deleted_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "searches", ["category_id"], name: "index_searches_on_category_id", using: :btree
  add_index "searches", ["deleted_at"], name: "index_searches_on_deleted_at", using: :btree
  add_index "searches", ["location"], name: "index_searches_on_location", using: :btree
  add_index "searches", ["site_id"], name: "index_searches_on_site_id", using: :btree
  add_index "searches", ["slug"], name: "index_searches_on_slug", using: :btree

  create_table "site_settings", force: :cascade do |t|
    t.string   "type"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "value_type_id"
  end

  add_index "site_settings", ["key"], name: "index_site_settings_on_key", using: :btree
  add_index "site_settings", ["site_id"], name: "index_site_settings_on_site_id", using: :btree
  add_index "site_settings", ["value_type_id"], name: "index_site_settings_on_value_type_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "host"
    t.boolean  "active",           default: false
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "name"
    t.text     "stylesheet"
    t.integer  "port"
    t.string   "public_key"
    t.string   "logo_image_url"
    t.text     "settings"
    t.text     "env"
    t.datetime "established_at"
    t.integer  "visits",           default: 0
    t.datetime "deleted_at"
    t.boolean  "blogging_enabled", default: false
    t.integer  "redirect_id"
  end

  add_index "sites", ["deleted_at"], name: "index_sites_on_deleted_at", using: :btree
  add_index "sites", ["host"], name: "index_sites_on_host", unique: true, using: :btree
  add_index "sites", ["redirect_id"], name: "index_sites_on_redirect_id", using: :btree
  add_index "sites", ["user_id"], name: "index_sites_on_user_id", using: :btree

  create_table "support_tickets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "staff_id"
    t.text     "message"
    t.string   "reply_to"
    t.string   "name"
    t.boolean  "open",       default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "site_id"
    t.string   "page"
  end

  add_index "support_tickets", ["site_id"], name: "index_support_tickets_on_site_id", using: :btree
  add_index "support_tickets", ["user_id"], name: "index_support_tickets_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "template_files", force: :cascade do |t|
    t.text     "body"
    t.string   "path"
    t.string   "locale"
    t.string   "handler"
    t.boolean  "partial",    default: false
    t.string   "format"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "site_id"
    t.text     "style"
    t.text     "script"
  end

  add_index "template_files", ["site_id"], name: "index_template_files_on_site_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "site_id"
    t.boolean  "admin",                             default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.string   "uid"
    t.string   "provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.boolean  "show_business_contact_information"
    t.string   "business_contact_name"
    t.string   "business_contact_email"
    t.string   "business_contact_phone"
    t.string   "username"
    t.string   "encryption_method",                 default: "sha1", null: false
    t.string   "email",                             default: "",     null: false
    t.string   "encrypted_password",                default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "is_suspended",                      default: false
    t.integer  "plan_id"
    t.string   "customer_id"
    t.string   "subscription_id"
    t.string   "card_last_4"
    t.string   "card_type"
    t.boolean  "on_trial"
    t.string   "coupon"
    t.datetime "trial_expires_at"
    t.boolean  "on_trial_grace_period",             default: false
    t.boolean  "active",                            default: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "deleted_at"
    t.boolean  "activity_notifications",            default: true
    t.boolean  "saved_search_notifications",        default: true
    t.boolean  "favorite_listing_notifications",    default: true
    t.string   "full_name"
    t.string   "migration_key"
    t.boolean  "elite",                             default: false
    t.boolean  "blogger",                           default: false
    t.string   "contact_name"
    t.boolean  "enable_directory",                  default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["plan_id"], name: "index_users_on_plan_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "boost_intervals", "sites"
  add_foreign_key "boost_levels", "sites"
  add_foreign_key "categories", "category_syndicates"
  add_foreign_key "favorites", "listings"
  add_foreign_key "favorites", "users"
  add_foreign_key "listing_drafts", "listings"
  add_foreign_key "listing_drafts", "sites"
  add_foreign_key "listing_drafts", "users"
  add_foreign_key "listing_messages", "listings"
  add_foreign_key "listing_messages", "users"
  add_foreign_key "listing_photos", "listings"
  add_foreign_key "listing_photos", "photos"
  add_foreign_key "listings", "boost_intervals"
  add_foreign_key "listings", "boost_levels"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "photo_assignments", "photos"
  add_foreign_key "photos", "sites"
  add_foreign_key "photos", "users"
  add_foreign_key "plans", "sites"
  add_foreign_key "saved_searches", "searches"
  add_foreign_key "saved_searches", "users"
  add_foreign_key "searches", "categories"
  add_foreign_key "searches", "sites"
  add_foreign_key "support_tickets", "sites"
  add_foreign_key "support_tickets", "users"
  add_foreign_key "template_files", "sites"
  add_foreign_key "users", "plans"
end
