# frozen_string_literal: true

# Calculator for assessment scores.
class ReportCard
  attr_reader :participant, :assessment_cases

  def initialize(participant:, assessment_cases:)
    @participant = participant
    @assessment_cases = assessment_cases
  end

  def percent_correct(question)
    return 0 if assessment_cases.count.zero?

    (
      100.0 *
        participant.correct_responses_for_question_and_cases(
          question: question,
          cases: assessment_cases
        ).count /
        assessment_cases.count
    ).round
  end
end
