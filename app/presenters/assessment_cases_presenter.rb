# frozen_string_literal: true

# extra logic for AssessmentCases views
class AssessmentCasesPresenter < SimpleDelegator
  def initialize(assessment_type)
    @assessment_type = assessment_type
  end

  def pretty_title
    type = @assessment_type.titleize.gsub("Assessment Case", "")
    "#{type} Assessment"
  end
end
