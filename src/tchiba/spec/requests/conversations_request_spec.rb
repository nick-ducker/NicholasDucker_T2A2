require 'rails_helper'

RSpec.describe "Conversations", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/conversations/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/conversations/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/conversations/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/conversations/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /add" do
    it "returns http success" do
      get "/conversations/add"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/conversations/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
