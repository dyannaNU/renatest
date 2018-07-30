# frozen_string_literal: true

# Formats each story
class StoriesPresenter < SimpleDelegator
  def stories
    Story.includes(:skill).order(:created_at)
  end

  def story_event
    story_events.build
  end

  def completed?(story)
    story_event_exists?(story)
  end

  # rubocop:disable Metrics/LineLength
  def below_benchmark_score?(story, average_skill_score)
    average_skill_score < story
                          .benchmark_percentage_for_training_status(training_status)
  end
end
