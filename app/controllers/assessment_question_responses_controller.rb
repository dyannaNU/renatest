# frozen_string_literal: true

# responses to assessment questions submitted by participant
class AssessmentQuestionResponsesController < ApplicationController
  BASELINE_TYPE = BaselineAssessmentCase.to_s
  FINAL_TYPE = FinalAssessmentCase.to_s

  def update_responses
    set_assessment_question_responses
    update_assessment_question_responses
  end

  private

  def assessment_question_responses_params
    return [] unless params[:assessment_question_responses]

    params
      .require(:assessment_question_responses)
      .permit(
        @assessment_question_responses.map do |r|
          { :"#{r.id.to_s}" =>
            %i[assessment_case_id assessment_question_id assessment_answer_id] }
        end
      )
  end

  def assessment_type
    params[:assessment_type]
  end

  def set_assessment_question_responses
    @assessment_question_responses = []
    params[:assessment_question_responses].each do |response|
      @assessment_question_responses <<
        AssessmentQuestionResponse.find(response)
    end
  end

  def update_assessment_question_responses
    update_response_with_assessment_question_response!
    redirect_after_save
  rescue StandardError => error
    flash[:alert] = error.message
    redirect_to_assessment(current_case_position)
  end

  def next_case
    assessment_klass.find_by(position: current_case_position + 1)
  end

  def current_case_position
    current_case_id = @assessment_question_responses
                      .first.try(:assessment_case_id)
    current_case_id ? AssessmentCase.find(current_case_id).position : 1
  end

  def redirect_to_assessment(position)
    if beyond_case_count?(position)
      redirect_to assessment_case_path(
        assessment_klass.find_by(position: position),
        type: assessment_klass
      )
    else
      redirect_to congratulations_route(assessment_klass)
    end
  end

  def redirect_after_save
    current_participant.update(assessment_case: next_case)

    return redirect_to home_path if params[:redirect_home] == "true"

    redirect_to_assessment(current_case_position + 1)
  end

  def beyond_case_count?(position)
    position <= assessment_klass.order(:position).last.position
  end

  def assessment_klass
    assessment_type.constantize
  end

  def congratulations_route(assessment_klass)
    if assessment_klass == BaselineAssessmentCase
      baseline_congratulations_path
    else
      final_congratulations_path
    end
  end

  def update_response_with_assessment_question_response!
    all_responses_provided = true
    AssessmentQuestionResponse.transaction do
      @assessment_question_responses.each do |response|
        response_params = assessment_question_responses_params[response.id.to_s]
        all_responses_provided &=
          response_params[:assessment_answer_id].present?
        response.update!(response_params)
      end
    end
    raise "Please answer all questions" unless all_responses_provided
  end
end
