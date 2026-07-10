class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email_address: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def guest_user?
    email_address == GUEST_USER_EMAIL
  end
end
