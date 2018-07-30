# frozen_string_literal: true

# A static controller to display a message when Participants are past the access
# period.
class PastAccessesController < ActionController::Base
  protect_from_forgery with: :exception

  layout "application"

  def show; end
end
