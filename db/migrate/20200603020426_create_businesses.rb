class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :sector
      t.string :headquarters
      t.string :website
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
