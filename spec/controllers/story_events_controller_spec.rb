# frozen_string_literal: true

require "rails_helper"

RSpec.describe StoryEventsController, type: :controller do
  describe "POST #create" do
    context "with valid params" do
      let(:participant) { create :participant }
      let!(:consent) { create :consent, participant: participant }
      let!(:story) { create :story }

      before { sign_in participant }

      describe "when post via js" do
        it "records a new story event" do
          expect do
            post :create,
                 params: {
                   story_events: { story_identifier: story.identifier }
                 },
                 format: :js
          end.to change(StoryEvent, :count).by(1)
        end

        it "redirects to module index" do
          post :create,
               params: {
                 story_events: { story_identifier: story.identifier }
               },
               format: :js

          expect(response)
            .to redirect_to modules_path
        end

        it "displays alert message" do
          post :create,
               params: {
                 story_events: { story_identifier: story.identifier }
               },
               format: :js

          expect(flash[:notice])
            .to eq "Congratulations you completed the module MyString"
        end
      end
    end

    context "with invalid params" do
      let(:errors) do
        double "errors", full_messages: %w[foo bar]
      end
      let(:event) do
        instance_double StoryEvent, save: false, id: 1, errors: errors
      end
      let(:participant) do
        create(:participant, consent: create(:consent))
      end
      let(:story) { instance_double Story, id: 1 }

      before do
        expect(request.env["warden"])
          .to receive(:authenticate!) { participant }
        allow(controller)
          .to receive(:current_participant) { participant }
        allow(Story)
          .to receive(:find_by!) { story }
        allow(participant)
          .to receive_message_chain(:story_events, :build)
          .and_return(event)
      end

      it "redirects to modules index page" do
        post :create,
             params: { story_events: { story_identifier: 1 } }, format: :js

        expect(response)
          .to redirect_to(modules_path)
      end

      it "renders error message" do
        post :create,
             params: { story_events: { story_identifier: 1 } }, format: :js

        expect(flash.alert)
          .to eq "There was an error: foo and bar"
      end
    end
  end
end
