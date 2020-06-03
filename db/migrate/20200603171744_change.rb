class Change < ActiveRecord::Migration[5.2]
  def change
    rename_column :businesses, :headquarters, :city
  end
end
