# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/final_report_cards
class FinalReportCardsPreview < ActionMailer::Preview
  def attach
    FinalReportCardsMailer.attach(
      participant_email: "foo@bar.com",
      pdf: PDFKit.new("<h1>test</h1>").to_pdf
    )
  end
end
