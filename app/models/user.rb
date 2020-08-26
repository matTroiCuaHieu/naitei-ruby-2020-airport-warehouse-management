class User < ApplicationRecord
  USER_PARAMS = %i(name email password password_confirmation).freeze

  belongs_to :warehouse
  belongs_to :unit
  has_many :requests, dependent: :destroy

  attr_accessor :remember_token

  validates :password, presence: true, length: {minimum: Settings.validate.user.password_minlength},
    allow_nil: true

  delegate :name, to: :warehouse, prefix: true, allow_nil: true

  has_secure_password

  class << self
    def User.digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def User.new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def forget
    update remember_digest: nil
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end
end
