# frozen_string_literal: true

# Used ONLY in development to speed up manual logins.
class QuickSignInsController < ActionController::Base
  protect_from_forgery with: :exception

  def new
    if params[:user_id]
      resource = User.where(id: params[:user_id]).first
    elsif params[:participant_id]
      resource = Participant.where(id: params[:participant_id]).first
    end

    return unless resource

    sign_in_and_redirect resource
  end
end
