# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Unrecognized routes", type: :request do
  it "redirect to the root" do
    get "/"

    expect(response.status).to eq 302

    get "/foo"

    expect(response.status).to eq 301

    post "/"

    expect(response.status).to eq 301

    post "/foo"

    expect(response.status).to eq 301
  end
end
