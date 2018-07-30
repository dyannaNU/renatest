# frozen_string_literal: true

# actions for baseline assessment report card which reports baseline assessment
# score to the participant
class BaselineReportCardsController < ApplicationController
  def show
    @baseline_report_card = ReportCard.new(
      participant: current_participant,
      assessment_cases: BaselineAssessmentCase.all
    )
  end
end
