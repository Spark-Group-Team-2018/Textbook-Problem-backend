class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.float :lat
      t.float :lon
      t.decimal :price
      t.boolean :is_public
      t.references :textbook, foreign_key: true

      t.timestamps
    end
  end
end
