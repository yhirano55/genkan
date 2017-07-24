require "rails_helper"

RSpec.describe Genkan do
  describe ".configure" do
    example do
      expect {
        described_class.configure do |config|
          config.user_class_name = "User"
        end
      }.not_to raise_error
    end
  end

  describe ".config" do
    subject { described_class.config }
    it { is_expected.to be_an_instance_of Genkan::Config }
  end

  describe "version" do
    subject { described_class::VERSION }
    it { is_expected.to be_a String }
  end
end
