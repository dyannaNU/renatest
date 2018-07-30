# frozen_string_literal: true

require "rails_helper"

RSpec.describe ModuleFile, type: :model do
  let(:module_file) { create :module_file }

  after { ModuleFile.destroy_all }

  describe "validations" do
    it { expect(module_file).to be_valid }

    describe "is invalid with no title" do
      before { module_file.title = nil }

      it { expect(module_file).to be_invalid }
    end

    describe "is invalid with no asset" do
      before { module_file.asset = nil }

      it { expect(module_file).to be_invalid }
    end
  end
end
