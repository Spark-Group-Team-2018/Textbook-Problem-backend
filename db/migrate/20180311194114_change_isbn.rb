class ChangeIsbn < ActiveRecord::Migration[5.1]
  def change

    drop_table :books

    create_table :books do |t|
      t.integer :ISBN, :limit => 13
      t.string :title
      t.string :description
      t.references :manufacturer, foreign_key: true

      t.timestamps
    end

  end
end