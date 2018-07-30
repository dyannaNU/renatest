# frozen_string_literal: true

# extra logic for home page
# rubocop:disable Metrics/ClassLength
class HomesPresenter < SimpleDelegator
  attr_reader :participant, :view_context
  include Rails.application.routes.url_helpers

  BASELINE_FEEDBACK_QUESTION_TYPE = BaselineFeedbackQuestion.to_s
  BASELINE_ASSESSMENT_CASE_TYPE = BaselineAssessmentCase.to_s
  LIST_ITEM_CLASS = "list-group-item list-group-item-action"
  HOW_TO_TITLE = "Instructions and Overview"
  BASELINE_FEEDBACK_TITLE = "User Feedback Questionnaire"
  BASELINE_ASSESSMENT_TITLE = "Baseline Assessment"
  BASELINE_REPORT_TITLE = "Baseline Assessment Report Card"
  MODULES_TITLE = "Modules"
  MODULE_COUNT = 8
  FINAL_FEEDBACK_QUESTION_TITLE = "Final Feedback Questionnaire"
  FINAL_FEEDBACK_QUESTION_TYPE = FinalFeedbackQuestion.to_s
  FINAL_ASSESSMENT_CASE_TITLE = "Final Assessment"
  FINAL_ASSESSMENT_CASE_TYPE = FinalAssessmentCase.to_s
  FINAL_REPORT_TITLE = "Final Assessment Report Card"

  def initialize(current_participant, view_context)
    @participant = current_participant
    @view_context = view_context
  end

  def how_to_link
    menu_link HOW_TO_TITLE, how_to_guide_path
  end

  def baseline_feedback_link
    return unless needs_to_complete_feedback?

    menu_link BASELINE_FEEDBACK_TITLE,
              feedback_questionnaire_path(
                type: BASELINE_FEEDBACK_QUESTION_TYPE
              )
  end

  def baseline_assessment_link
    return unless needs_to_complete_baseline?

    if started_baseline_assessment?
      menu_link_to_next_assessment(
        BASELINE_ASSESSMENT_TITLE, BASELINE_ASSESSMENT_CASE_TYPE
      )
    else
      menu_link BASELINE_ASSESSMENT_TITLE,
                introduction_path(type: BASELINE_ASSESSMENT_CASE_TYPE)
    end
  end

  def baseline_report_link
    return unless completed_baseline_assessment?

    menu_link BASELINE_REPORT_TITLE, baseline_report_card_path
  end

  def modules_link
    return unless completed_baseline_assessment?
    return if started_final_assessment?

    menu_link MODULES_TITLE, modules_path, data: { turbolinks: false }
  end

  def final_assessment_link
    return unless viewed_required_modules?
    return if completed_final_assessment?

    if started_final_assessment?
      menu_link_to_next_assessment(
        FINAL_ASSESSMENT_CASE_TITLE, FINAL_ASSESSMENT_CASE_TYPE
      )
    else
      menu_link FINAL_ASSESSMENT_CASE_TITLE,
                introduction_path(type: FINAL_ASSESSMENT_CASE_TYPE)
    end
  end

  def menu_link_to_next_assessment(title, type)
    menu_link title,
              assessment_case_path(participant.assessment_case, type: type)
  end

  def final_feedback_questionnaire_link
    return unless completed_final_assessment?
    return if final_feedback_questionnaire?

    menu_link FINAL_FEEDBACK_QUESTION_TITLE,
              feedback_questionnaire_path(
                type: FINAL_FEEDBACK_QUESTION_TYPE
              )
  end

  def final_report_card_link
    return unless final_feedback_questionnaire?

    menu_link FINAL_REPORT_TITLE, final_report_card_path
  end

  private

  def completed_baseline_assessment?
    participant.completed_assessment_case?(BaselineAssessmentCase)
  end

  def completed_final_assessment?
    participant.completed_assessment_case?(FinalAssessmentCase)
  end

  def final_feedback_questionnaire?
    participant
      .final_feedback_questions
      .present?
  end

  def menu_link(text, path, options = {})
    view_context
      .link_to text, path, options.merge(class: LIST_ITEM_CLASS)
  end

  def completed_how_to
    participant.any_how_to_event
  end

  def needs_to_complete_feedback?
    completed_how_to &&
      !completed_feedback?(BASELINE_FEEDBACK_QUESTION_TYPE)
  end

  def completed_feedback?(type)
    participant.completed_all_questionnaire_items?(type)
  end

  def needs_to_complete_baseline?
    completed_how_to &&
      completed_feedback?(BASELINE_FEEDBACK_QUESTION_TYPE) &&
      !completed_baseline_assessment?
  end

  def started_baseline_assessment?
    participant
      .baseline_assessment_cases
      .present?
  end

  def last_baseline_case_position
    BaselineAssessmentCase.order(:position).last.position
  end

  def started_final_assessment?
    participant
      .final_assessment_cases
      .present?
  end

  def viewed_required_modules?
    module_completion = ModuleCompletion.new(
      participant: participant,
      stories: Story,
      baseline_assessment_cases: BaselineAssessmentCase
    )
    module_completion.completed_modules?
  end
end
# rubocop:enable Metrics/ClassLength
