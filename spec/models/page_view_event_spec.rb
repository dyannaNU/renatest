# frozen_string_literal: true

require "rails_helper"

RSpec.describe PageViewEvent, type: :model do
  describe "validations" do
    let(:page_view_event) { create  :page_view_event }

    it { expect(page_view_event).to be_valid }

    describe "is invalid with no participant" do
      before { page_view_event.participant = nil }

      it { expect(page_view_event).to_not be_valid }
    end

    describe "is invalid with no type" do
      before { page_view_event.type = nil }

      it { expect(page_view_event).to_not be_valid }
    end
  end
end
