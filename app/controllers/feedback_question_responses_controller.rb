# frozen_string_literal: true

# actions for responses to feedback questions
class FeedbackQuestionResponsesController < ApplicationController
  POSITION_OF_ATTRIBUTE = 1

  def create
    FeedbackQuestionResponse
      .transaction { feedback_question_responses.each(&:save!) }

    redirect_to home_path, notice: "Feedback questionnaire successfully saved."
  rescue ActiveRecord::RecordInvalid => error
    flash[:alert] = error.message

    redirect_to feedback_questionnaire_path(type: feedback_type)
  end

  private

  def feedback_type
    params[:feedback_type]
  end

  def feedback_question_responses_params
    return [] unless params[:feedback_question_responses]

    params
      .require(:feedback_question_responses)
      .permit(
        feedback_type.constantize.all.map.with_index do |_response, index|
          { :"#{index}" => %i[feedback_question_id response_choice] }
        end
      )
  end

  def feedback_question_responses
    @feedback_question_responses ||=
      feedback_question_responses_params.to_hash.map do |attrs|
        current_participant
          .feedback_question_responses
          .build(attrs[POSITION_OF_ATTRIBUTE])
      end
  end
end
