# frozen_string_literal: true

require "rails_helper"

RSpec.describe FinalReportCardsMailer, type: :mailer do
  describe "attach" do
    let(:mail) do
      FinalReportCardsMailer.attach(
        participant_email: "to@example.org",
        pdf: PDFKit.new("<h1>test</h1>").to_pdf
      )
    end

    it "renders the headers" do
      expect(mail.subject).to eq("Your Final Report Card from EMC2")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["esophageal.quality@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello")
      expect(mail.body.encoded).to match("Please find your final report card")
    end
  end
end
