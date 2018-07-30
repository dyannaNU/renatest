# frozen_string_literal: true

require "forms/errors_helper"

# actions for the consents which must be completed before any other
# action can be taken on the patient facing site
class ConsentsController < ApplicationController
  before_action :check_for_existing_consent, only: :new

  def new
    @consent = Consent.new
  end

  def create
    @consent = current_participant.build_consent(response: true)

    if @consent.save
      redirect_to home_path, notice: "Consent successfully created"
    else
      render :new
    end
  end

  private

  # Overrides ApplicationController
  def check_for_existing_consent
    redirect_to home_path if current_participant.consent
  end
end
