class User < ApplicationRecord
  #associations
  has_one :auth , dependent: :destroy
  has_many :sessions , dependent: :destroy # check
  has_many :lists, dependent: :destroy

  #validations
  validates :name , presence: :true
  validates :email , presence: :true
  validates :username , presence: :true , uniqueness: true
  validates :user_type, presence: true, inclusion: {in: USER_TYPE_RANGE}
end
