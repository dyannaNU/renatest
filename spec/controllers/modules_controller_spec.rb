# frozen_string_literal: true

require "rails_helper"

RSpec.describe ModulesController, type: :controller do
  let(:participant) { create :participant }

  before do
    create :consent, participant: participant
    sign_in participant
  end

  after { ModuleFile.destroy_all }

  describe "GET #index" do
    before { get :index }

    it { expect(response).to be_success }
  end

  describe "GET #download_zip_file" do
    context "when module files exist" do
      before do
        create :module_file

        get :download_zip_file
      end

      it { expect(response).to be_success }
    end

    context "when module files do not exist" do
      before do
        get :download_zip_file
      end

      it { expect(response).to redirect_to modules_url }
    end
  end
end
