# frozen_string_literal: true

require "rails_helper"

module Participants
  RSpec.describe RegistrationsController, type: :controller do
    let(:participant) { create :participant }

    describe "GET #new" do
      before { get :new }

      it { expect(response).to be_success }
    end

    describe "GET #edit" do
      before do
        create :consent, participant: participant
        sign_in participant
        get :edit, params: { participant: participant }
      end

      it { expect(response).to be_success }
    end

    describe "POST #create" do
      context "with valid params" do
        let!(:token) { create :access_token, token: "foo" }

        it "creates a new participant" do
          expect do
            post :create, params: {
              participant: {
                email: "foobar@example.com",
                first_name: "foo",
                last_name: "bar",
                affiliation: "foobar",
                training_status_id: TrainingStatus.first,
                password: "asdfasdf",
                password_confirmation: "asdfasdf"
              },
              access_token: "foo"
            }
          end.to change(Participant, :count).by(1)
        end
      end

      context "with invalid params" do
        it "re-renders new" do
          post :create, params: { participant: { email: nil } }

          expect(response).to render_template :new
        end
      end
    end

    describe "POST #update" do
      before do
        create :consent, participant: participant
        sign_in participant
      end

      context "with valid params" do
        it "updates record" do
          put :update, params: {
            id: participant.id,
            participant: {
              current_password: participant.password,
              first_name: "FOOBAR"
            }
          }
          participant.reload

          expect(participant.first_name).to eq "FOOBAR"
        end
      end

      context "with invalid params" do
        it "re-renders edit" do
          put :update, params: {
            id: participant.id,
            current_password: participant.password,
            participant: {
              first_name: nil
            }
          }

          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      before do
        create :consent, participant: participant
        sign_in participant
      end

      it "deletes record" do
        expect do
          delete :destroy, params: {
            id: participant.id
          }
        end.to change(Participant, :count).by(-1)
      end
    end
  end
end
