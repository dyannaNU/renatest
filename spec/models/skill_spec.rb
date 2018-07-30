# frozen_string_literal: true

require "rails_helper"

RSpec.describe Skill, type: :model do
  let!(:skill) { Skill.create(title: "test") }

  describe "validations" do
    describe "is invalid with no title" do
      before { skill.title = nil }
      it { expect(skill).to_not be_valid }
    end

    describe "is unique" do
      it do
        skill = Skill.create(title: "test")
        expect(skill).to_not be_valid
      end
    end
  end
end
