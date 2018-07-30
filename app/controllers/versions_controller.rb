# frozen_string_literal: true

# Render release version data.
class VersionsController < ActionController::Base
  protect_from_forgery with: :exception

  after_action :cors_set_access_control_headers

  def show
    version = Rails.application.class.parent::VERSION

    respond_to do |format|
      format.text { render plain: version }
      format.json { render json: { value: version } }
    end
  end

  private

  def cors_set_access_control_headers
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "GET"
    headers["Access-Control-Allow-Headers"] = "Content-Type"
  end
end
