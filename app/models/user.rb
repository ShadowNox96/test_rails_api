class User < ActiveRecord::Base
  has_secure_password

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: true,
                    uniqueness: true
end
