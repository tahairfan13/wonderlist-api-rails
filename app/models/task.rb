class Task < ApplicationRecord
 #associations
 belongs_to :list
 #validations
 validates :name ,presence: :true
 validates :list_id ,presence: :true
end
