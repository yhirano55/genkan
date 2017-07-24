require "rails_helper"

RSpec.describe Genkan::Config do
  let(:config) { described_class.new }

  describe "initialize" do
    it { expect(config.user_class_name).to eq "User" }
    it { expect(config.auto_acceptance).to eq false }
  end

  describe "#user_class" do
    before { config.user_class_name = user_class_name }
    subject { config.user_class }

    context "user_class_name exist" do
      let(:user_class_name) { "User" }
      it("returns constant") { is_expected.to be User }
    end

    context "user_class_name unexist" do
      let(:user_class_name) { "Anonymous" }
      it { is_expected.to be_nil }
    end
  end

  describe "#current_user_method_name" do
    before { config.user_class_name = user_class_name }
    subject { config.current_user_method_name }

    context "without namespace" do
      let(:user_class_name) { "AdminUser" }
      it("returns correctly method name") { is_expected.to eq "current_admin_user" }
    end

    context "with namespace" do
      let(:user_class_name) { "Admin::User" }
      it("returns correctly method name") { is_expected.to eq "current_admin_user" }
    end
  end

  describe "#auto_acceptance?" do
    before { config.auto_acceptance = auto_acceptance }
    subject { config.auto_acceptance? }

    context "auto_acceptance is true" do
      let(:auto_acceptance) { true }
      it { is_expected.to eq true }
    end

    context "auto_acceptance is false" do
      let(:auto_acceptance) { false }
      it { is_expected.to eq false }
    end

    context "auto_acceptance is nil" do
      let(:auto_acceptance) { nil }
      it { is_expected.to eq false }
    end
  end
end
