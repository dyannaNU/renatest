# frozen_string_literal: true

# actions for the home page
class HomesController < ApplicationController
  def show
    @presenter = HomesPresenter.new(current_participant, view_context)
  end
end
