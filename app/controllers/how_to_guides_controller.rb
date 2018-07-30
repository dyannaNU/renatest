# frozen_string_literal: true

# actions for the how to guides which are shown to the participant after consent
# and then available for review
class HowToGuidesController < ApplicationController
  def show
    HowToViewEvent.create(participant: current_participant)
  end
end
