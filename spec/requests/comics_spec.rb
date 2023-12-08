require 'rails_helper'

RSpec.describe "Root", type: :request do
  fixtures :all

  describe "GET /" do
    it "gets the root path showing today's comic" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /manage" do
    it "gets the root path of the comic manager" do
      get manage_root_path
      expect(response).to have_http_status(200)
    end

  end
end
