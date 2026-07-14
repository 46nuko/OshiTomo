class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_one_attached :profile_image
  validates :name, length: { in: 2..20 }, uniqueness: true
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

  def is_active?
    is_active
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
