class CreatePhilanthropicInitiatives < ActiveRecord::Migration[5.2]
  def change
    create_table :philanthropic_initiatives do |t|
      t.string :recipient
      t.string :city
      t.string :state
      t.integer :business_id
      t.integer :beneficiary_id

      t.timestamps
    end
  end
end
