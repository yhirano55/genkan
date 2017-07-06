require "rails_helper"

RSpec.feature "authentication" do
  before do
    allow_any_instance_of(Genkan::Config).to receive(:auto_acceptance).and_return(true)
    stub_omniauth(email: email)
    visit "/login"
    click_link "login"
  end

  feature "Sign up" do
    let(:email) { Faker::Internet.email }

    scenario "User can sign up" do
      expect(page).to have_content I18n.t("genkan.sessions.logged_in")
    end
  end

  feature "Login" do
    context "When user is accepted" do
      let(:user) { create :user, :accepted }
      let(:email) { user.email }

      scenario "User can login" do
        expect(page).to have_content I18n.t("genkan.sessions.logged_in")
      end
    end

    context "When user is banned" do
      let(:user) { create :user, :banned }
      let(:email) { user.email }

      scenario "User cannot login" do
        expect(page).to have_content I18n.t("errors.messages.banned")
      end
    end
  end

  feature "Logout" do
    let(:email) { Faker::Internet.email }

    scenario "User can logout" do
      click_link "logout"
      expect(page).to have_content I18n.t("genkan.sessions.logged_out")
    end
  end
end
