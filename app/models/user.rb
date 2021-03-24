class User < ApplicationRecord
  has_many :days, dependent: :destroy
  has_many :workouts, dependent: :destroy
  has_many :traning_menus, dependent: :destroy
  
  # 「remember_token」という仮想の属性を作成します。
  attr_accessor :remember_token
  scope :get_by_name, ->(name) {where("name like ?", "%#{name}%")}
  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  
  has_secure_password
  validates :password, presence: false, on: :facebook_login, length: { minimum: 6 }, allow_nil: true
      
  # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def self.from_omniauth(auth)
    # emailの提供は必須とする
    user = User.where('email = ?', auth.info.email).first
    if user.blank?
      user = User.create!(
        uid: auth.uid,
        name: auth.info.name,
        email: auth.info.email,
        oauth_token: auth.credentials.token,
        oauth_expires_at: Time.at(auth.credentials.expires_at),
        password: "password",
        password_confirmation: "password"
        )
    else
      user.uid   = auth.uid
      user.name  = auth.info.name
      user.email = auth.info.email
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
    user
  end


  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name", "email", "affiliation",
    "password", "admin"]
  end
  
  
end