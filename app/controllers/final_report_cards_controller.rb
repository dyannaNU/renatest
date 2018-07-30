# frozen_string_literal: true

# actions for final assessment report card which reports
# final assessment score to the participant
class FinalReportCardsController < ApplicationController
  def show
    set_report_cards

    respond_to do |format|
      format.html
      format.pdf
    end
  end

  def attach
    set_report_cards
    printable_html = render_to_string(template: "final_report_cards/printable")
    pdf = PDFKit
          .new(replace_relative_paths(remove_script_tags(printable_html)))
          .to_pdf
    FinalReportCardsMailer
      .attach(participant_email: current_participant.email, pdf: pdf)
      .deliver_now

    redirect_to final_report_card_url
  end

  private

  def set_report_cards
    @baseline_report_card = ReportCard.new(
      participant: current_participant,
      assessment_cases: BaselineAssessmentCase.all
    )
    @final_report_card = ReportCard.new(
      participant: current_participant,
      assessment_cases: FinalAssessmentCase.all
    )
  end

  # Replace relative paths in HTML with paths prefixed by the root URL.
  def replace_relative_paths(html)
    html.gsub(%r{(href|src)=(['"])/([^/"']([^\"']*|[^"']*))?['"]},
              "\\1=\\2#{root_url}\\3\\2")
  end

  # Remove <script> tags from HTML to prevent unnecessary JS loading.
  def remove_script_tags(html)
    html.gsub(%r{<script[^<]+</script>}, "")
  end
end
