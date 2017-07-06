require 'rails_helper'

RSpec.describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'scope' do
    let!(:accepted)     { create :user, :accepted }
    let!(:not_accepted) { create :user, :not_accepted }
    let!(:banned)       { create :user, :banned }
    let!(:not_banned)   { create :user, :not_banned }
    let!(:active)       { create :user, :active }

    describe '.accepted' do
      subject { described_class.accepted }

      it('includes accepted') { is_expected.to include accepted }
      it('includes active') { is_expected.to include active }
      it('does not include not_accepted') { is_expected.not_to include not_accepted }
    end

    describe '.not_banned' do
      subject { described_class.not_banned }

      it('includes not_banned') { is_expected.to include not_banned }
      it('includes active') { is_expected.to include active }
      it('does not include banned') { is_expected.not_to include banned }
    end

    describe '.active' do
      subject { described_class.active }

      it('includes active') { is_expected.to include active }
      it('does not include not_accepted') { is_expected.not_to include not_accepted }
      it('does not include not_banned') { is_expected.not_to include not_banned }
    end
  end

  describe 'validation' do
    describe 'email' do
      before { create :user }

      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email) }
    end

    describe '#ensure_record_has_accepted' do
      before { model.valid?(:login) }

      subject { model.errors.full_messages }

      context 'with accepted' do
        let(:model) { build :user, :accepted }
        it { is_expected.not_to include I18n.t('errors.messages.not_accepted') }
      end

      context 'with not_accepted' do
        let(:model) { build :user, :not_accepted }
        it { is_expected.to include I18n.t('errors.messages.not_accepted') }
      end
    end

    describe '#ensure_record_has_not_banned' do
      before { model.valid?(:login) }

      subject { model.errors.full_messages }

      context 'with not_banned' do
        let(:model) { build :user, :not_banned }
        it { is_expected.not_to include I18n.t('errors.messages.banned') }
      end

      context 'with banned' do
        let(:model) { build :user, :banned }
        it { is_expected.to include I18n.t('errors.messages.banned') }
      end
    end
  end

  describe 'callback' do
    let(:user) { build(:user) }

    it 'set remember_token before create' do
      expect(user.remember_token).to be_blank
      user.save!
      expect(user.remember_token).to be_present
    end
  end

  describe '#login!' do
    let(:logged_in_count) { rand(1..20) }
    let(:user) { build :user, logged_in_count: logged_in_count }

    subject(:execute) do
      config = double(:config)
      allow(config).to receive(:auto_acceptance?).and_return(auto_acceptance)
      allow(Genkan).to receive(:config).and_return(config)
      user.login!
    end

    context 'when auto_acceptance is true' do
      let(:auto_acceptance) { true }

      before { execute }

      it 'stores last_logged_in_at' do
        expect(user.last_logged_in_at).to be_present
      end

      it 'increments loggin_in_count' do
        expect(user.logged_in_count).to eq (logged_in_count + 1)
      end
    end

    context 'when auto_acceptance is false' do
      let(:auto_acceptance) { false }

      it 'raise error ActiveRecord::RecordInvalid' do
        expect { execute }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#accepted?' do
    subject { user.accepted? }

    context 'with accepted' do
      let(:user) { build :user, :accepted }
      it { is_expected.to eq true }
    end

    context 'with not_accepted' do
      let(:user) { build :user, :not_accepted }
      it { is_expected.to eq false }
    end
  end

  describe '#accept' do
    let(:user) { build :user }

    subject { user.tap(&:accept) }

    it { is_expected.to be_accepted }
  end

  describe '#accept!' do
    let(:user) { build :user }

    subject { user.tap(&:accept!) }

    it { is_expected.to be_accepted }
    it { is_expected.to be_persisted }
  end

  describe '#banned?' do
    subject { user.banned? }

    context 'with banned' do
      let(:user) { build :user, :banned }
      it { is_expected.to eq true }
    end

    context 'with not_banned' do
      let(:user) { build :user, :not_banned }
      it { is_expected.to eq false }
    end
  end

  describe '#ban' do
    let(:user) { build :user }

    subject { user.tap(&:ban) }

    it { is_expected.to be_banned }
  end

  describe '#ban!' do
    let(:user) { build :user }

    subject { user.tap(&:ban!) }

    it { is_expected.to be_banned }
    it { is_expected.to be_persisted }
  end
end
