class AddOmniauthToBusinesses < ActiveRecord::Migration[5.2]
  def change
    add_column :businesses, :google_token, :string
    add_column :businesses, :google_refresh_token, :string
  end
end
