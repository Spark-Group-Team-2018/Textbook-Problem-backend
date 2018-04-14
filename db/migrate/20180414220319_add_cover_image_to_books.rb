class AddCoverImageToBooks < ActiveRecord::Migration[5.1]
  def up
    add_column :books, :cover_image_link, :string
  end

  def down
    remove_column :books, :cover_image_link
  end
end
