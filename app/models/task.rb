class Task < ApplicationRecord
 #associations
 belongs_to :list
 has_many :document, as: :documentable, dependent: :destroy
 #validations
 validates :name ,presence: :true
 validates :list_id ,presence: :true
end
