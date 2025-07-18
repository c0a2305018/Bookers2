class AddBookNameToPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :book_name, :string
  end
end
