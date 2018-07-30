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

ActiveRecord::Schema.define(version: 20170915160753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assessment_answers", force: :cascade do |t|
    t.bigint "assessment_question_id", null: false
    t.string "position", null: false
    t.string "title", null: false
    t.boolean "is_correct", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assessment_case_id", null: false
    t.index ["assessment_case_id"], name: "index_assessment_answers_on_assessment_case_id"
    t.index ["assessment_question_id"], name: "index_assessment_answers_on_assessment_question_id"
  end

  create_table "assessment_cases", force: :cascade do |t|
    t.integer "position", null: false
    t.text "description", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assessment_question_responses", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "assessment_case_id", null: false
    t.bigint "assessment_question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assessment_answer_id"
    t.index ["assessment_answer_id"], name: "index_assessment_question_responses_on_assessment_answer_id"
    t.index ["assessment_case_id"], name: "index_assessment_question_responses_on_assessment_case_id"
    t.index ["assessment_question_id"], name: "index_assessment_question_responses_on_assessment_question_id"
    t.index ["participant_id"], name: "index_assessment_question_responses_on_participant_id"
  end

  create_table "assessment_questions", force: :cascade do |t|
    t.integer "position", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "skill_id", null: false
    t.index ["skill_id"], name: "index_assessment_questions_on_skill_id"
  end

  create_table "benchmark_scores", force: :cascade do |t|
    t.bigint "skill_id", null: false
    t.bigint "training_status_id", null: false
    t.integer "percentage", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_benchmark_scores_on_skill_id"
    t.index ["training_status_id"], name: "index_benchmark_scores_on_training_status_id"
  end

  create_table "case_files", force: :cascade do |t|
    t.bigint "assessment_case_id", null: false
    t.string "title"
    t.string "description"
    t.string "asset_file_name", null: false
    t.string "asset_content_type", null: false
    t.integer "asset_file_size", null: false
    t.datetime "asset_updated_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_case_id"], name: "index_case_files_on_assessment_case_id"
  end

  create_table "consents", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.boolean "response", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_consents_on_participant_id"
  end

  create_table "feedback_question_responses", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "feedback_question_id", null: false
    t.string "response_choice", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feedback_question_id"], name: "index_feedback_question_responses_on_feedback_question_id"
    t.index ["participant_id"], name: "index_feedback_question_responses_on_participant_id"
  end

  create_table "feedback_questions", force: :cascade do |t|
    t.string "type", null: false
    t.string "description", null: false
    t.string "response_options", null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "module_files", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.string "asset_file_name", null: false
    t.string "asset_content_type", null: false
    t.integer "asset_file_size", null: false
    t.datetime "asset_updated_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_view_events", force: :cascade do |t|
    t.string "type", null: false
    t.bigint "participant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_page_view_events_on_participant_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "affiliation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timezone", default: "Central Time (US & Canada)", null: false
    t.bigint "assessment_case_id"
    t.bigint "training_status_id", null: false
    t.index ["assessment_case_id"], name: "index_participants_on_assessment_case_id"
    t.index ["confirmation_token"], name: "index_participants_on_confirmation_token", unique: true
    t.index ["email"], name: "index_participants_on_email", unique: true
    t.index ["reset_password_token"], name: "index_participants_on_reset_password_token", unique: true
    t.index ["training_status_id"], name: "index_participants_on_training_status_id"
    t.index ["unlock_token"], name: "index_participants_on_unlock_token", unique: true
  end

  create_table "sent_notifications", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_sent_notifications_on_participant_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stories", force: :cascade do |t|
    t.string "file_name", null: false
    t.string "identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "skill_id", null: false
    t.index ["skill_id"], name: "index_stories_on_skill_id"
  end

  create_table "story_events", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.datetime "completed_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "story_id", null: false
    t.index ["participant_id"], name: "index_story_events_on_participant_id"
    t.index ["story_id"], name: "index_story_events_on_story_id"
  end

  create_table "training_statuses", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "assessment_answers", "assessment_cases"
  add_foreign_key "assessment_answers", "assessment_questions"
  add_foreign_key "assessment_question_responses", "assessment_answers"
  add_foreign_key "assessment_question_responses", "assessment_cases"
  add_foreign_key "assessment_question_responses", "assessment_questions"
  add_foreign_key "assessment_question_responses", "participants"
  add_foreign_key "assessment_questions", "skills"
  add_foreign_key "benchmark_scores", "skills"
  add_foreign_key "benchmark_scores", "training_statuses"
  add_foreign_key "case_files", "assessment_cases"
  add_foreign_key "consents", "participants"
  add_foreign_key "feedback_question_responses", "feedback_questions"
  add_foreign_key "feedback_question_responses", "participants"
  add_foreign_key "page_view_events", "participants"
  add_foreign_key "participants", "assessment_cases"
  add_foreign_key "participants", "training_statuses"
  add_foreign_key "sent_notifications", "participants"
  add_foreign_key "stories", "skills"
end
