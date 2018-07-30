# frozen_string_literal: true

require "rails_helper"

RSpec.describe TrainingStatus, type: :model do
  let(:training_status) { TrainingStatus.create(title: "master") }

  describe "validations" do
    describe "is invalid with no title" do
      before { training_status.title = nil }
      it { expect(training_status).to_not be_valid }
    end

    describe "is unique" do
      before { training_status.title = "master" }
      it { expect(training_status).to_not be_valid }
    end
  end
end
