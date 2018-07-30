# frozen_string_literal: true

# actions for feedback questionnaires completed by participant at baseline and
# final assessments
class FeedbackQuestionnairesController < ApplicationController
  def show
    set_feedback_type
    check_for_completed_questionnaire
    questions = FeedbackQuestion.where(type: @feedback_type)
    @feedback_question_responses = questions.map do |question|
      current_participant.feedback_question_responses
                         .build(feedback_question: question)
    end
  end

  private

  def set_feedback_type
    @feedback_type = params[:type]
  end

  def check_for_completed_questionnaire
    return unless current_participant
                  .completed_all_questionnaire_items?(@feedback_type)
    redirect_to home_path,
                notice: "You have already completed the feedback questionnaire."
  end
end
