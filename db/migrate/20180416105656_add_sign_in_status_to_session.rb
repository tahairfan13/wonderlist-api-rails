class AddSignInStatusToSession < ActiveRecord::Migration[5.1]
  def change
    add_column :sessions, :sign_in_status, :boolean, null: false, default: true
    add_index :sessions, :sign_in_status
  end
end
