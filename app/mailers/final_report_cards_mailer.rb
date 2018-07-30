# frozen_string_literal: true

# Delivers PDF attached final report card to participants.
class FinalReportCardsMailer < ApplicationMailer
  ATTACH_SUBJECT = "Your Final Report Card from EMC2"

  def attach(participant_email:, pdf:)
    attachments["report_card.pdf"] = pdf
    mail to: participant_email, subject: ATTACH_SUBJECT
  end
end
