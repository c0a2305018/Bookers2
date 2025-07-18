class RenamePostImagesToBooks < ActiveRecord::Migration[6.1]
  def change
    rename_table :post_images, :books
  end
end
