class CreateCbsas < ActiveRecord::Migration[5.0]
  def change
    create_table :metropolitan_statistical_areas do |t|
      t.string :cbsa
      t.string :name
      t.bigint :popestimate2014
      t.bigint :popestimate2015

      t.timestamps
    end

    add_index :metropolitan_statistical_areas, :cbsa

    create_table :mdiv_cbsas do |t|
      t.string :cbsa
      t.string :mdiv
    end

    add_index :mdiv_cbsas, :mdiv
  end
end
