class User < ApplicationRecord
  belongs_to :warehouse
  USER_PARAMS = %i(name email password password_confirmation).freeze

  validates :password, presence: true, length: {minimum: Settings.user.password_minimum},
                       allow_nil: true

  has_secure_password

  def forget
    update remember_digest: nil
  end
end
