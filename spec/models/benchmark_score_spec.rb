# frozen_string_literal: true

require "rails_helper"

RSpec.describe BenchmarkScore, type: :model do
  describe ".percentage_for_training_status" do
    let(:benchmark) { create :benchmark_score }

    context "when there is no benchmark with the training status" do
      it "returns 0" do
        expect(BenchmarkScore.percentage_for_training_status("hello")).to eq 0
      end
    end

    it "returns the percentage" do
      expect(BenchmarkScore
        .percentage_for_training_status(benchmark.training_status))
        .to eq benchmark.percentage
    end
  end
end
