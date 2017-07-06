require 'rails_helper'

RSpec.describe WelcomeController do
  describe 'GET #index' do
    let(:user) { create :user }

    before do
      allow(controller).to receive(:current_user).and_return(user) if enable_login_stub
      get :index
    end

    context 'with authenticated' do
      let(:enable_login_stub) { true }

      it { expect(response).to have_http_status(200) }
      it { expect(response).to render_template(:index) }
    end

    context 'without authenticated' do
      let(:enable_login_stub) { false }

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(Genkan::Engine.routes.url_helpers.login_path) }
    end
  end
end
