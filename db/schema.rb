# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_26_101136) do
  create_table "active_admin_comments", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "shop_name"
    t.bigint "longitude"
    t.bigint "latitude"
    t.string "merchant_id", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.boolean "super_admin", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.bigint "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.index ["confirmation_token"], name: "index_admin_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admin_users_on_unlock_token", unique: true
  end

  create_table "carts", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.bigint "admin_user_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["admin_user_id", "customer_id"], name: "index_carts_on_admin_user_id_and_customer_id", unique: true
    t.index ["admin_user_id"], name: "index_carts_on_admin_user_id"
    t.index ["customer_id"], name: "index_carts_on_customer_id"
  end

  create_table "categories", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "name"
    t.string "amharic"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "customers", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.bigint "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.index ["confirmation_token"], name: "index_customers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_customers_on_unlock_token", unique: true
  end

  create_table "feedbacks", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.text "body"
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["customer_id"], name: "index_feedbacks_on_customer_id"
  end

  create_table "items", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "itemable_type", null: false
    t.bigint "itemable_id", null: false
    t.bigint "product_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["customer_id"], name: "index_items_on_customer_id"
    t.index ["itemable_type", "itemable_id"], name: "index_items_on_itemable"
    t.index ["product_id", "customer_id"], name: "index_items_on_product_id_and_customer_id", unique: true
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "jwt_blacklists", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "jti"
    t.datetime "exp", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "orders", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "admin_user_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["admin_user_id"], name: "index_orders_on_admin_user_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "product_comments", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.text "body"
    t.bigint "customer_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["customer_id"], name: "index_product_comments_on_customer_id"
    t.index ["product_id"], name: "index_product_comments_on_product_id"
  end

  create_table "products", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.float "discount"
    t.string "origin"
    t.bigint "quantity", default: 1
    t.text "description"
    t.bigint "category_id", null: false
    t.bigint "admin_user_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["admin_user_id"], name: "index_products_on_admin_user_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["name"], name: "index_products_on_name"
  end

  create_table "votes", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.bigint "vote_weight"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "carts", "admin_users"
  add_foreign_key "carts", "customers"
  add_foreign_key "feedbacks", "customers"
  add_foreign_key "items", "customers"
  add_foreign_key "items", "products"
  add_foreign_key "orders", "admin_users"
  add_foreign_key "orders", "customers"
  add_foreign_key "product_comments", "customers"
  add_foreign_key "product_comments", "products"
  add_foreign_key "products", "admin_users"
  add_foreign_key "products", "categories"
end
