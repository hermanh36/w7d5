class User < ApplicationRecord
  validates :username, :session_token, :password_digest, presence: true
  validates :username, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  attr_reader :password
  after_initialize :ensure_session_token

  has_many :subs,
    foreign_key: :moderator_id,
    class_name: :Sub,
    dependent: :destroy

  has_many :posts,
    foreign_key: :author_id,
    class_name: :Post,
    dependent: :destroy

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
