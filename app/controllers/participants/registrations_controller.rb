# frozen_string_literal: true

module Participants
  # extra logic for custom devise registration views for participants
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    # POST /resource
    def create
      return super if valid_token?

      build_resource(sign_up_params)
      resource.valid?
      resource.errors.add :access_token, :invalid
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

    private

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer
        .permit(:sign_up,
                keys:
                  %i[first_name
                     last_name
                     affiliation
                     training_status_id
                     timezone])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer
        .permit(:account_update,
                keys:
                  %i[first_name
                     last_name
                     affiliation
                     training_status_id
                     timezone])
    end

    # The path used after sign up.
    def after_sign_up_path_for(_resource)
      new_participant_session_path
    end

    # The path used after sign up for inactive accounts.
    def after_inactive_sign_up_path_for(_resource)
      new_participant_session_path
    end

    def valid_token?
      Concerns::TokenValidator
        .new(params[:access_token]).valid?
    end
  end
end
