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

ActiveRecord::Schema.define(:version => 20130827181256) do

  create_table "attachments", :force => true do |t|
    t.integer  "issue_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
  end

  create_table "authentications", :force => true do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "devices", :force => true do |t|
    t.string   "device_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "issue_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
  end

  create_table "issues", :force => true do |t|
    t.string   "name"
    t.date     "issue_date"
    t.boolean  "is_free"
    t.string   "publisher"
    t.string   "app_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "description"
    t.integer  "publisher_id"
    t.string   "product_identifier"
    t.datetime "issue_publish_date"
  end

  create_table "issues_users", :force => true do |t|
    t.integer  "issue_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "previews", :force => true do |t|
    t.integer  "issue_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "item_file_name"
    t.string   "item_content_type"
    t.integer  "item_file_size"
    t.datetime "item_updated_at"
  end

  create_table "purchases", :force => true do |t|
    t.string   "app_id"
    t.string   "user_id"
    t.string   "product_identifier"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "receipts", :force => true do |t|
    t.string   "app_id"
    t.string   "quantity"
    t.string   "product_identifier"
    t.string   "type"
    t.string   "transaction_id"
    t.string   "user_id"
    t.string   "purchase_date"
    t.string   "original_purchase_date"
    t.string   "original_transaction_id"
    t.string   "app_item_id"
    t.string   "version_external_identifier"
    t.string   "bid"
    t.string   "bvrs"
    t.text     "base64_receipt"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "shares", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "app_id"
    t.string   "user_id"
    t.string   "product_identifier"
    t.datetime "effective_date"
    t.datetime "expiration_date"
    t.datetime "last_validated"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "password_reset_token"
    t.string   "publisher"
    t.string   "role"
  end

end
