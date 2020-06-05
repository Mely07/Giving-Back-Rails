class ChangeUsernameToEmail < ActiveRecord::Migration[5.2]
  def change
      rename_column :businesses, :email, :email
  end
end
