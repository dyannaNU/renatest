# frozen_string_literal: true

# Parent controller that shows instructions
# to participants before baseline and final assessments
class IntroductionsController < ApplicationController
  def show
    render File.join("introductions", directory_name, "show")
  rescue NameError => exception
    redirect_to home_path, alert: "There was an error: #{exception.message}"
  end

  def update
    if current_participant.update(assessment_case: assessment_case)
      redirect_to assessment_case_path(assessment_case, type: assessment_type)
    else
      alert_message
      render File.join("introductions", directory_name, "show")
    end
  end

  private

  def assessment_case
    assessment_type.constantize.order(:position).first
  end

  def assessment_type
    params[:type]
  end

  def alert_message
    flash[:alert] =
      "There was an error: "\
      "#{current_participant.errors.full_messages.to_sentence}"
  end

  def directory_name
    assessment_type.constantize.to_s.tableize
  end
end
