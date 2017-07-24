require "rails_helper"

RSpec.describe Genkan::SessionsController do
  routes { Genkan::Engine.routes }

  before do
    stub_omniauth
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  end

  describe "GET #new" do
    before { get :new }
    it { expect(response).to have_http_status(200) }
  end

  describe "POST #create" do
    subject(:execution) { post :create, params: { provider: :google } }

    context "when auto_acceptance is true" do
      before { allow_any_instance_of(Genkan::Config).to receive(:auto_acceptance).and_return(true) }

      it "creates a user" do
        expect { execution }.to change { User.count }.by(1)
      end

      it "creates a session" do
        expect(session[:remember_token]).to be_nil
        execution
        expect(session[:remember_token]).to be_present
      end

      it "redirects root_path" do
        execution
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(Dummy::Application.routes.url_helpers.root_path)
      end
    end

    context "when auto_acceptance is false" do
      before { allow_any_instance_of(Genkan::Config).to receive(:auto_acceptance).and_return(false) }

      it "creates a user" do
        expect { execution }.to change { User.count }.by(1)
      end

      it "redirects login_path" do
        execution
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "GET #destroy" do
    before do
      allow_any_instance_of(Genkan::Config).to receive(:auto_acceptance).and_return(true)
      post :create, params: { provider: :google }
    end

    subject(:execution) { get :destroy }

    it "destroys a session" do
      expect(session[:remember_token]).to be_present
      execution
      expect(session[:remember_token]).to be_nil
    end

    it "redirects login_path" do
      execution
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(login_path)
    end
  end
end
