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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120523055839) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "cities", :force => true do |t|
    t.string  "name"
    t.string  "en_name"
    t.integer "region_id"
  end

  add_index "cities", ["region_id"], :name => "index_cities_on_region_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "qq"
    t.string   "company"
    t.string   "address"
    t.string   "title"
    t.text     "message"
    t.string   "cate",       :default => "联系我们"
    t.text     "note"
    t.boolean  "is_verfied", :default => false
    t.string   "verfied_by"
    t.boolean  "is_deleted", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dish_cates", :force => true do |t|
    t.string   "name",        :limit => 64
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dishes", :force => true do |t|
    t.integer  "dish_cate_id"
    t.string   "name",         :limit => 128
    t.string   "alilas",       :limit => 128
    t.string   "photo_url",    :limit => 64
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dishes", ["dish_cate_id"], :name => "index_dishes_on_dish_cate_id"

  create_table "districts", :force => true do |t|
    t.string  "name"
    t.string  "en_name"
    t.integer "city_id"
  end

  add_index "districts", ["city_id"], :name => "index_districts_on_city_id"

  create_table "news_cates", :force => true do |t|
    t.string "name"
  end

  add_index "news_cates", ["name"], :name => "index_news_cates_on_name", :unique => true

  create_table "news_items", :force => true do |t|
    t.integer  "news_cate_id"
    t.string   "title"
    t.text     "body"
    t.string   "external_path"
    t.string   "image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news_items", ["news_cate_id"], :name => "index_news_items_on_news_cate_id"
  add_index "news_items", ["title"], :name => "index_news_items_on_title"

  create_table "page_parts", :force => true do |t|
    t.integer "page_id"
    t.integer "part_id"
    t.integer "position", :default => 0
  end

  add_index "page_parts", ["page_id"], :name => "index_page_parts_on_page_id"
  add_index "page_parts", ["part_id"], :name => "index_page_parts_on_part_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "parent_id",        :default => 0
    t.integer  "position",         :default => 0
    t.string   "path_name"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "menu_match"
    t.integer  "show_in_menu",     :default => 1
    t.integer  "deletable",        :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"
  add_index "pages", ["path_name"], :name => "index_pages_on_path_name", :unique => true
  add_index "pages", ["title"], :name => "index_pages_on_title"

  create_table "parts", :force => true do |t|
    t.string "title"
    t.text   "body"
  end

  add_index "parts", ["title"], :name => "index_parts_on_title", :unique => true

  create_table "product_cates", :force => true do |t|
    t.string "name"
  end

  create_table "product_items", :force => true do |t|
    t.integer  "product_cate_id"
    t.string   "title"
    t.text     "description"
    t.decimal  "price",           :precision => 10, :scale => 2
    t.string   "image_path"
    t.boolean  "is_visible",                                     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_items", ["product_cate_id"], :name => "index_product_items_on_product_cate_id"

  create_table "project_cates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_cates", ["name"], :name => "index_project_cates_on_name"

  create_table "project_items", :force => true do |t|
    t.integer  "project_cate_id"
    t.string   "tags"
    t.string   "status"
    t.string   "title"
    t.string   "summary"
    t.text     "content"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "company"
    t.string   "city"
    t.string   "address"
    t.string   "site_url"
    t.integer  "sort_id",         :default => 10000
    t.boolean  "is_verfied",      :default => false
    t.boolean  "is_forager",      :default => false
    t.string   "forager_url"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_items", ["project_cate_id"], :name => "index_project_items_on_project_cate_id"
  add_index "project_items", ["title"], :name => "index_project_items_on_title"

  create_table "regions", :force => true do |t|
    t.string "name"
    t.string "en_name"
  end

  create_table "resource_cates", :force => true do |t|
    t.string "name"
  end

  create_table "resource_items", :force => true do |t|
    t.string   "resource_type"
    t.integer  "resource_cate_id"
    t.string   "resource_name"
    t.string   "resource_path"
    t.string   "resource_note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resource_items", ["resource_cate_id"], :name => "index_resource_items_on_resource_cate_id"
  add_index "resource_items", ["resource_type"], :name => "index_resource_items_on_resource_type"

  create_table "shop_addresses", :force => true do |t|
    t.integer  "shop_id"
    t.integer  "zone_id"
    t.integer  "region_id"
    t.integer  "city_id"
    t.integer  "district_id"
    t.string   "addr",        :limit => 64
    t.string   "zip",         :limit => 16
    t.string   "latitude",    :limit => 16
    t.string   "longitude",   :limit => 16
    t.boolean  "is_geocoded",               :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shop_addresses", ["city_id"], :name => "index_shop_addresses_on_city_id"
  add_index "shop_addresses", ["district_id"], :name => "index_shop_addresses_on_district_id"
  add_index "shop_addresses", ["region_id"], :name => "index_shop_addresses_on_region_id"
  add_index "shop_addresses", ["shop_id"], :name => "index_shop_addresses_on_shop_id"
  add_index "shop_addresses", ["zone_id"], :name => "index_shop_addresses_on_zone_id"

  create_table "shop_contacts", :force => true do |t|
    t.integer  "shop_id"
    t.string   "contacter_name", :limit => 32
    t.string   "tel_phone",      :limit => 16
    t.string   "mobile_phone",   :limit => 16
    t.string   "qq",             :limit => 16
    t.string   "email",          :limit => 16
    t.string   "other",          :limit => 512
    t.string   "jiaotong",       :limit => 128
    t.string   "website",        :limit => 32
    t.string   "weibo",          :limit => 32
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shop_contacts", ["shop_id"], :name => "index_shop_contacts_on_shop_id"

  create_table "shop_dishes", :force => true do |t|
    t.integer  "shop_id"
    t.integer  "dish_id"
    t.string   "price",          :limit => 16
    t.boolean  "is_discount"
    t.float    "discount_value"
    t.text     "description"
    t.string   "note",           :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shop_dishes", ["dish_id"], :name => "index_shop_dishes_on_dish_id"
  add_index "shop_dishes", ["shop_id"], :name => "index_shop_dishes_on_shop_id"

  create_table "shops", :force => true do |t|
    t.string   "name",            :limit => 128
    t.text     "description"
    t.string   "avg",             :limit => 64
    t.string   "biz_time",        :limit => 64
    t.string   "note"
    t.float    "rate"
    t.float    "score"
    t.float    "score_kouwei"
    t.float    "score_sudu"
    t.float    "score_fuwu"
    t.string   "photo_url",       :limit => 128
    t.string   "shop_cate",       :limit => 128
    t.string   "tags"
    t.string   "secret",          :limit => 32
    t.boolean  "has_out_food",                   :default => false
    t.boolean  "has_out_people",                 :default => false
    t.boolean  "is_new_added",                   :default => false
    t.boolean  "is_hot",                         :default => false
    t.date     "hot_unitl"
    t.boolean  "is_discount",                    :default => false
    t.float    "discount_value"
    t.integer  "updated_by",                     :default => 0
    t.boolean  "is_contacted",                   :default => false
    t.boolean  "is_dealed",                      :default => false
    t.string   "original_source", :limit => 32
    t.string   "original_url",    :limit => 128
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shops", ["has_out_food"], :name => "index_shops_on_has_out_food"
  add_index "shops", ["has_out_people"], :name => "index_shops_on_has_out_people"
  add_index "shops", ["is_contacted"], :name => "index_shops_on_is_contacted"
  add_index "shops", ["is_dealed"], :name => "index_shops_on_is_dealed"
  add_index "shops", ["is_discount"], :name => "index_shops_on_is_discount"
  add_index "shops", ["is_hot"], :name => "index_shops_on_is_hot"
  add_index "shops", ["is_new_added"], :name => "index_shops_on_is_new_added"
  add_index "shops", ["name"], :name => "index_shops_on_name"

  create_table "sites", :force => true do |t|
    t.string "name"
    t.string "value"
  end

  add_index "sites", ["name"], :name => "index_sites_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "zones", :force => true do |t|
    t.string   "name",       :limit => 64
    t.string   "alias",      :limit => 64
    t.string   "addr",       :limit => 128
    t.string   "latitude",   :limit => 16
    t.string   "longitude",  :limit => 16
    t.decimal  "range",                     :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
