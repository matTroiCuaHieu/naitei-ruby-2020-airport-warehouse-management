class User < ApplicationRecord
  belongs_to :warehouse

  validates :password, presence: true, length: {minimum: Settings.validate.user.password_minlength},
    allow_nil: true

  has_secure_password
end
