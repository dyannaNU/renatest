# frozen_string_literal: true

# Controller superclass.
class ApplicationController < ActionController::Base
  RECORD_NOT_FOUND = "Sorry, we had trouble with that request. " \
                     "Please try again."
  ACCESS_PERIOD = 90.days

  protect_from_forgery

  before_action :authenticate_participant!, :set_raven_user_context
  before_action :check_for_access_period, unless: :devise_controller?
  before_action :check_for_existing_consent

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    redirect_to home_path, alert: RECORD_NOT_FOUND
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    send("new_#{resource_or_scope}_session_path")
  end

  private

  def check_for_access_period
    return unless current_participant

    earliest = Time.zone.now - ApplicationController::ACCESS_PERIOD
    return if current_participant.created_at >= earliest

    redirect_to past_access_url,
                alert: "You may not access this application after " \
                       "#{ACCESS_PERIOD.inspect}."
  end

  def check_for_existing_consent
    return unless current_participant
    return if current_participant.consent
    redirect_to new_consent_path,
                alert: "You must consent to use this application."
  end

  # rubocop:disable LineLength
  def set_raven_user_context
    Raven.user_context(participant_id: current_participant.id) if current_participant
  end
  # rubocop:enable LineLength
end
