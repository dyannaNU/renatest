# frozen_string_literal: true

# Determines whether the participant has completed
# the required modules to move on
class ModuleCompletion
  attr_reader :participant, :stories, :baseline_assessment_cases

  def initialize(participant:, stories:, baseline_assessment_cases:)
    @participant = participant
    @stories = stories
    @baseline_assessment_cases = baseline_assessment_cases
  end

  def completed_modules?
    return false if stories.count.zero?
    complete = 0
    stories.find_each do |story|
      if score(story) >= find_benchmark(story) || participant
         .story_event_exists?(story)
        complete += 1
      end
    end
    complete == stories.count
  end

  private

  def score(story)
    return 0 if baseline_assessment_cases.count.zero?

    (100 * participant.correct_responses_for_question_and_cases(
      question: story.assessment_question, cases: baseline_assessment_cases.all
    ).count /
      baseline_assessment_cases.count).round
  end

  def find_benchmark(story)
    story.benchmark_percentage_for_training_status(participant.training_status)
  end
end
