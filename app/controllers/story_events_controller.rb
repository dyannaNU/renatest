# frozen_string_literal: true

# Captures when a story has been completed by participants
class StoryEventsController < ApplicationController
  def create
    if story_event.save
      flash[:notice] = "Congratulations you completed the module #{story.title}"
    else
      flash[:alert] = "There was an error: "\
                      "#{story_event.errors.full_messages.to_sentence}"
    end
    redirect_to modules_path
  end

  private

  def story_events_params
    params
      .require(:story_events)
      .permit(:story_identifier)
  end

  def story_event
    @story_event ||=
      current_participant
      .story_events
      .build(completed_at: Time.zone.now, story_id: story.id)
  end

  def story
    Story
      .find_by!(
        identifier:
          story_events_params[:story_identifier]
      )
  end
end
