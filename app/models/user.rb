class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :email, presence: true, uniqueness: { case_sensitive: false }
  validates :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validates :password_digest, presence: { message: "Password cannot be blank" }

  has_one :province, dependent: :destroy
  has_one :nation_membership, through: :province
  has_one :nation, through: :nation_membership # :whoa:

  # Paperclip, for avatars
  has_attached_file :avatar, styles: { medium: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 1.megabytes

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

  def has_applied_to_join?(nation)
    province.pending_nation_memberships.where(nation_id: nation.id).empty?
  end

  def nation_admin?(nation)
    return if nation_membership.nil? || nation.nil?

    nation_membership.nation_id == nation.id &&
      nation_membership.state == "active" &&
      !nation_membership.rank.nil? &&
      nation_membership.rank < 2
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
