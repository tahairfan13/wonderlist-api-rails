class Auth < ApplicationRecord
  #associations
  belongs_to :user
  #validations
  has_secure_password
  validates :password_confirmation, presence: true, if: :password
  validates :status, presence: true, inclusion: {in: AUTH_STATUS_RANGE} # to check the status in our case blocked and unblocked
end
