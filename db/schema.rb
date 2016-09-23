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

ActiveRecord::Schema.define(version: 20160923212039) do

  create_table "agents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "team_id"
    t.bigint   "customid"
    t.boolean  "disabled"
    t.index ["team_id"], name: "index_agents_on_team_id", using: :btree
  end

  create_table "broadcasts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "controller"
    t.string   "item"
    t.integer  "user_id"
    t.boolean  "read",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "controller"
    t.integer  "item"
    t.integer  "creator"
    t.integer  "recipient"
    t.text     "message",      limit: 65535
    t.boolean  "read",                       default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "user"
    t.boolean  "supervisor"
    t.boolean  "team_leader"
    t.boolean  "junior_admin"
    t.boolean  "admin"
  end

  create_table "qa_general_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "setting_id"
    t.integer  "team_id"
    t.boolean  "disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qa_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "setting_id"
    t.integer  "team_id"
    t.string   "qa"
    t.text     "description", limit: 65535
    t.integer  "out_of"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "position"
  end

  create_table "qas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "qa_setting_id"
    t.integer  "ticket_id"
    t.integer  "score"
    t.integer  "out_of"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "rat_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "setting_id"
    t.index ["setting_id"], name: "index_rat_types_on_setting_id", using: :btree
  end

  create_table "rats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "agent_id"
    t.string   "notes"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "rat_type_id"
    t.integer  "admin_user_id"
    t.boolean  "req_delete"
    t.text     "req_reason",    limit: 65535
    t.index ["admin_user_id"], name: "index_rats_on_admin_user_id", using: :btree
    t.index ["rat_type_id"], name: "index_rats_on_rat_type_id", using: :btree
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name"
    t.text     "description", limit: 65535
    t.boolean  "enabled"
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "tick_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "setting_id"
    t.index ["setting_id"], name: "index_tick_types_on_setting_id", using: :btree
  end

  create_table "tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "ticket_reference"
    t.date     "date"
    t.integer  "agent_id"
    t.decimal  "score",                          precision: 10, scale: 3
    t.text     "notes",            limit: 65535
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "ticks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "agent_id"
    t.string   "notes"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "tick_type_id"
    t.integer  "admin_user_id"
    t.boolean  "req_delete"
    t.text     "req_reason",    limit: 65535
    t.index ["admin_user_id"], name: "index_ticks_on_admin_user_id", using: :btree
    t.index ["tick_type_id"], name: "index_ticks_on_tick_type_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 50
    t.string   "username",        limit: 25
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "role"
    t.boolean  "disabled"
    t.integer  "agent_id"
    t.integer  "team_id"
    t.index ["agent_id"], name: "index_users_on_agent_id", using: :btree
    t.index ["team_id"], name: "index_users_on_team_id", using: :btree
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "item_type",  limit: 191,        null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 4294967295
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

end
