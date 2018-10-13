class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :stoken
      t.boolean :sign_in_status, null: false, default: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
