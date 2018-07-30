# frozen_string_literal: true

# actions for baseline assessment cases completed by participants
class AssessmentCasesController < ApplicationController
  def show
    set_type
    set_presenter
    check_for_completed_assessments
    set_case
    set_case_file
    set_assessment_question_responses
    create_assessment_case_page_event
  end

  private

  def set_type
    @assessment_type = params[:type]
  end

  def set_presenter
    @presenter = AssessmentCasesPresenter.new(@assessment_type)
  end

  def check_for_completed_assessments
    return unless current_participant
                  .completed_assessment_case?(@assessment_type.constantize)

    redirect_to home_path,
                alert: "You have already completed the assessment"
  end

  def set_case
    @case = @assessment_type.constantize.find(params[:id])
  end

  def set_case_file
    @case_file = @case.case_file
  end

  def set_assessment_question_responses
    find_or_create_assessment_question_responses
  rescue ActiveRecord::RecordInvalid => exception
    redirect_to home_path,
                alert: exception.message
  end

  def create_assessment_case_page_event
    current_participant
      .page_view_events
      .create!(type: @assessment_type + "ViewEvent")
  rescue ActiveRecord::SubclassNotFound => exception
    redirect_to home_path,
                alert: exception.message
  end

  def find_or_create_assessment_question_responses
    AssessmentQuestionResponse.transaction do
      @assessment_question_responses = AssessmentQuestion.all.map do |question|
        current_participant
          .assessment_question_responses
          .find_or_create_by!(
            assessment_case: @case,
            assessment_question: question
          )
      end
    end
  end
end
