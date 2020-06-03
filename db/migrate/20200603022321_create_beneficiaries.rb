class CreateBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :beneficiaries do |t|
      t.string :recipient
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
