class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name , null: false
      t.string :email, null: false
      t.string :username, null: false
      t.integer :user_type, null: false, default: 1

      t.timestamps
    end
  end
end
