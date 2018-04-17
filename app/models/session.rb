class Session < ApplicationRecord
  #associations
  belongs_to :user

  #prerquisite methods
  before_validation :generate_stoken, on: :create # creates a stoken on the just before saving the files

  #validations
  validates :sign_in_status, presence: :true
  validates :stoken, presence: true

  private

  def generate_stoken
    begin
     self.stoken = SecureRandom.base58(STOKEN_LENGTH)
    end while self.class.exists?(stoken: self.stoken) # using a loop to check the uniqeness of stoken
  end
end
