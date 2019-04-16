class CollapsedMigration < ActiveRecord::Migration[4.2]
  def change
    create_table "active_admin_comments", force: :cascade do |t|
      t.string   "namespace",     limit: 255
      t.text     "body",          limit: 65535
      t.string   "resource_id",   limit: 255,   null: false
      t.string   "resource_type", limit: 255,   null: false
      t.integer  "author_id",     limit: 4
      t.string   "author_type",   limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

    create_table "admin_users", force: :cascade do |t|
      t.string   "email",                  limit: 255, default: "", null: false
      t.string   "encrypted_password",     limit: 255, default: "", null: false
      t.string   "reset_password_token",   limit: 255
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip",     limit: 255
      t.string   "last_sign_in_ip",        limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

    create_table "ckeditor_assets", force: :cascade do |t|
      t.string   "data_file_name",    limit: 255, null: false
      t.string   "data_content_type", limit: 255
      t.integer  "data_file_size",    limit: 4
      t.integer  "assetable_id",      limit: 4
      t.string   "assetable_type",    limit: 30
      t.string   "type",              limit: 30
      t.integer  "width",             limit: 4
      t.integer  "height",            limit: 4
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

    create_table "collections", force: :cascade do |t|
      t.string   "title",              limit: 255
      t.text     "description",        limit: 65535
      t.datetime "created_at",                       null: false
      t.datetime "updated_at",                       null: false
      t.string   "slug",               limit: 255
      t.string   "image_file_name",    limit: 255
      t.string   "image_content_type", limit: 255
      t.integer  "image_file_size",    limit: 4
      t.datetime "image_updated_at"
    end

    add_index "collections", ["slug"], name: "index_collections_on_slug", using: :btree

    create_table "documents", force: :cascade do |t|
      t.string   "title",                      limit: 255
      t.integer  "year",                       limit: 4
      t.text     "description",                limit: 65535
      t.datetime "created_at",                               null: false
      t.datetime "updated_at",                               null: false
      t.string   "slug",                       limit: 255
      t.string   "document_file_file_name",    limit: 255
      t.string   "document_file_content_type", limit: 255
      t.integer  "document_file_file_size",    limit: 4
      t.datetime "document_file_updated_at"
    end

    add_index "documents", ["slug"], name: "index_documents_on_slug", using: :btree

    create_table "films", force: :cascade do |t|
      t.string   "title",                  limit: 255
      t.integer  "year",                   limit: 4
      t.text     "description",            limit: 65535
      t.datetime "created_at",                           null: false
      t.datetime "updated_at",                           null: false
      t.string   "duration",               limit: 255
      t.string   "slug",                   limit: 255
      t.string   "thumbnail_file_name",    limit: 255
      t.string   "thumbnail_content_type", limit: 255
      t.integer  "thumbnail_file_size",    limit: 4
      t.datetime "thumbnail_updated_at"
    end

    create_table "finding_aids", force: :cascade do |t|
      t.datetime "created_at",                               null: false
      t.datetime "updated_at",                               null: false
      t.string   "creator",                    limit: 255
      t.string   "title",                      limit: 255
      t.string   "dates_inclusive",            limit: 255
      t.string   "dates_bulk",                 limit: 255
      t.text     "abstract",                   limit: 65535
      t.text     "quantity",                   limit: 65535
      t.text     "location_note",              limit: 65535
      t.string   "language",                   limit: 255
      t.string   "call_phrase",                limit: 255
      t.text     "header",                     limit: 65535
      t.text     "historical_note",            limit: 65535
      t.text     "scope_note",                 limit: 65535
      t.text     "access_points",              limit: 65535
      t.text     "arrangement",                limit: 65535
      t.string   "slug",                       limit: 255
      t.string   "image_file_name",            limit: 255
      t.string   "image_content_type",         limit: 255
      t.integer  "image_file_size",            limit: 4
      t.datetime "image_updated_at"
      t.text     "administrative_information", limit: 65535
    end

    add_index "finding_aids", ["slug"], name: "index_finding_aids_on_slug", unique: true, using: :btree

    create_table "friendly_id_slugs", force: :cascade do |t|
      t.string   "slug",           limit: 255, null: false
      t.integer  "sluggable_id",   limit: 4,   null: false
      t.string   "sluggable_type", limit: 50
      t.string   "scope",          limit: 255
      t.datetime "created_at"
    end

    add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

    create_table "series", force: :cascade do |t|
      t.string   "title",          limit: 255
      t.text     "description",    limit: 65535
      t.text     "table",          limit: 65535
      t.datetime "created_at",                   null: false
      t.datetime "updated_at",                   null: false
      t.integer  "finding_aid_id", limit: 4
      t.string   "slug",           limit: 255
    end

    add_index "series", ["slug"], name: "index_series_on_slug", unique: true, using: :btree

    create_table "videos", force: :cascade do |t|
      t.string   "title",                   limit: 255
      t.text     "description",             limit: 65535
      t.string   "duration",                limit: 255
      t.datetime "created_at",                            null: false
      t.datetime "updated_at",                            null: false
      t.integer  "film_id",                 limit: 4
      t.text     "embed",                   limit: 65535
      t.integer  "collection_id",           limit: 4
      t.string   "slug",                    limit: 255
      t.string   "thumbnail_file_name",     limit: 255
      t.string   "thumbnail_content_type",  limit: 255
      t.integer  "thumbnail_file_size",     limit: 4
      t.datetime "thumbnail_updated_at"
      t.string   "name",                    limit: 255
      t.string   "transcript_file_name",    limit: 255
      t.string   "transcript_content_type", limit: 255
      t.integer  "transcript_file_size",    limit: 4
      t.datetime "transcript_updated_at"
    end

    add_index "videos", ["slug"], name: "index_videos_on_slug", using: :btree
  end
end
