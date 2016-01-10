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

ActiveRecord::Schema.define(version: 20160110204544) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.integer  "forum_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["forum_id"], name: "index_categories_on_forum_id", using: :btree

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "idea_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["idea_id"], name: "index_follows_on_idea_id", using: :btree
  add_index "follows", ["user_id"], name: "index_follows_on_user_id", using: :btree

  create_table "forums", force: :cascade do |t|
    t.string   "password",   limit: 255
    t.integer  "idea_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forums", ["idea_id"], name: "index_forums_on_idea_id", using: :btree

  create_table "idea_admins", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "idea_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "idea_admins", ["idea_id"], name: "index_idea_admins_on_idea_id", using: :btree
  add_index "idea_admins", ["user_id"], name: "index_idea_admins_on_user_id", using: :btree

  create_table "idea_comments", force: :cascade do |t|
    t.string   "message",    limit: 255
    t.integer  "idea_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "idea_comments", ["idea_id"], name: "index_idea_comments_on_idea_id", using: :btree
  add_index "idea_comments", ["user_id"], name: "index_idea_comments_on_user_id", using: :btree

  create_table "ideas", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "image_file_name",  limit: 255
    t.text     "mini_description", limit: 65535
    t.text     "description",      limit: 65535
    t.string   "video",            limit: 255
    t.string   "password",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "promoted"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.text     "body",                limit: 65535
    t.integer  "message_sender_id",   limit: 4
    t.integer  "message_receiver_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["message_receiver_id"], name: "index_messages_on_message_receiver_id", using: :btree
  add_index "messages", ["message_sender_id"], name: "index_messages_on_message_sender_id", using: :btree

  create_table "post_comments", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "message",    limit: 65535
    t.integer  "post_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_comments", ["post_id"], name: "index_post_comments_on_post_id", using: :btree
  add_index "post_comments", ["user_id"], name: "index_post_comments_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "message",     limit: 65535
    t.integer  "category_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["category_id"], name: "index_posts_on_category_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "nick",               limit: 255
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "access_token_login", limit: 255
    t.string   "image_file_name",    limit: 255
    t.text     "about",              limit: 65535
    t.string   "local",              limit: 255
    t.string   "website",            limit: 255
    t.string   "facebook",           limit: 255
    t.string   "twitter",            limit: 255
    t.string   "access_token",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",            limit: 4
    t.boolean  "updated_user"
  end

  create_table "providers", force: :cascade do |t|
    t.string   "provider",               limit: 255,   default: "email", null: false
    t.string   "uid",                    limit: 255,   default: "",      null: false
    t.string   "encrypted_password",     limit: 255,   default: "",      null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "image",                  limit: 255
    t.string   "email",                  limit: 255
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "providers", ["email"], name: "index_providers_on_email", using: :btree
  add_index "providers", ["reset_password_token"], name: "index_providers_on_reset_password_token", unique: true, using: :btree
  add_index "providers", ["uid", "provider"], name: "index_providers_on_uid_and_provider", unique: true, using: :btree

  create_table "user_comments", force: :cascade do |t|
    t.text     "message",             limit: 65535
    t.integer  "comment_sender_id",   limit: 4
    t.integer  "comment_receiver_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_comments", ["comment_receiver_id"], name: "index_user_comments_on_comment_receiver_id", using: :btree
  add_index "user_comments", ["comment_sender_id"], name: "index_user_comments_on_comment_sender_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "admin"
    t.integer  "latest_activity_id",     limit: 4
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tokens",                 limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
