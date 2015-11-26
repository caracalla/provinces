class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :email, presence: true, uniqueness: { case_sensitive: false }
  validates :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validates :password_digest, presence: { message: "Password cannot be blank" }

  has_one :province, dependent: :destroy
  has_one :nation_membership, through: :province
  has_one :nation, through: :nation_membership # :whoa:

  after_initialize :ensure_session_token

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.update!(session_token: self.class.generate_session_token)
    self.session_token
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
