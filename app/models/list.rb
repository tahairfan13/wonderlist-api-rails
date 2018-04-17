class List < ApplicationRecord
  #associations
  belongs_to :user
  has_many :tasks , dependent: :destroy
  #validations
  validates :name, presence: :true
end
