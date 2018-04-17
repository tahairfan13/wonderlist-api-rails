class CreateAuths < ActiveRecord::Migration[5.1]
  def change
    create_table :auths do |t|
      t.integer :status, null: false, default: 1
      t.string :password_digest, null: false
      t.belongs_to :user, foreign_key: true , null: false

      t.timestamps
    end
  end
end
