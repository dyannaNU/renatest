# frozen_string_literal: true

require "rails_helper"

RSpec.describe StoriesPresenter, type: :presenter do
  let(:participant) { instance_double Participant }
  let(:presenter) do
    StoriesPresenter.new(participant)
  end

  describe "#completed?" do
    context "when a story has been completed" do
      it "returns `true`" do
        allow(participant)
          .to receive(:story_event_exists?)
            .with(:story) { true }
        expect(presenter.completed?(:story))
          .to be true
      end
    end

    context "when a story has not been completed" do
      it "returns `false`" do
        allow(participant)
          .to receive(:story_event_exists?)
            .with(:story) { false }
        expect(presenter.completed?(:story))
          .to be false
      end
    end
  end

  describe "#below_benchmark_score?" do
    let(:story) { instance_double Story }

    context "when participant's avg skill score below their status benchmark" do
      it "returns `true`" do
        allow(participant)
          .to receive(:training_status) { :training_status }
        allow(story)
          .to receive(:benchmark_percentage_for_training_status)
            .with(:training_status) { 90 }
        expect(presenter.below_benchmark_score?(story, 80))
          .to be true
      end
    end

    context "when participant's avg skill score above their status benchmark" do
      it "returns `false`" do
        allow(participant)
          .to receive(:training_status) { :training_status }
        allow(story)
          .to receive(:benchmark_percentage_for_training_status)
            .with(:training_status) { 90 }
        expect(presenter.below_benchmark_score?(story, 100))
          .to be false
      end
    end
  end
end
