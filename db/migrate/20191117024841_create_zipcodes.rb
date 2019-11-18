class CreateZipcodes < ActiveRecord::Migration[5.0]
  def change
    create_table :zip_cbsas do |t|
      t.string :zip
      t.string :cbsa
    end
    add_index :zip_cbsas, :zip
  end
end
