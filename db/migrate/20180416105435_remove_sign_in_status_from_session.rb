class RemoveSignInStatusFromSession < ActiveRecord::Migration[5.1]
  def change
    remove_column :sessions, :sign_in_status, :boolean
  end
end
