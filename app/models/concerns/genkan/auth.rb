module Genkan
  module Auth
    extend ActiveSupport::Concern

    included do
      scope :accepted,   -> { where.not(accepted_at: nil) }
      scope :not_banned, -> { where(banned_at: nil) }
      scope :active,     -> { accepted.not_banned }

      validates :email, presence: true, uniqueness: true

      with_options on: :login do
        validate :ensure_record_has_accepted
        validate :ensure_record_has_not_banned
      end

      before_create do
        self.remember_token = SecureRandom.hex(20)
      end
    end

    def login
      store_last_logged_in_at
      increment_logged_in_count
      accept if Genkan.config.auto_acceptance?
    end

    def login!
      login
      save!(context: :login)
    end

    def accepted?
      accepted_at.present?
    end

    def accept
      self.accepted_at = Time.current
    end

    def accept!
      accept
      save!
    end

    def banned?
      banned_at.present?
    end

    def ban
      self.banned_at = Time.current
    end

    def ban!
      ban
      save!
    end

    private

    def store_last_logged_in_at
      self.last_logged_in_at = Time.current
    end

    def increment_logged_in_count
      self.logged_in_count ||= 0
      self.logged_in_count += 1
    end

    def ensure_record_has_accepted
      errors.add(:base, :not_accepted) unless accepted?
    end

    def ensure_record_has_not_banned
      errors.add(:base, :banned) if banned?
    end
  end
end
