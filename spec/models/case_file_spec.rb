# frozen_string_literal: true

require "rails_helper"

RSpec.describe CaseFile, type: :model do
  let(:case_file) { create :case_file }

  after { CaseFile.destroy_all }

  describe "validations" do
    it { expect(case_file).to be_valid }

    describe "invalid with no assessment_case" do
      before { case_file.assessment_case = nil }

      it { expect(case_file).to be_invalid }
    end

    describe "invalid with no asset" do
      before { case_file.asset = nil }

      it { expect(case_file).to be_invalid }
    end
  end
end
