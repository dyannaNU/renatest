# frozen_string_literal: true

require "rails_helper"

RSpec.describe PastAccessesController, type: :controller do
  describe "GET #show" do
    before { get :show }

    it { expect(response).to be_success }
  end
end
