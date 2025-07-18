class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      # t.references :user, null: false, foreign_key: true
      t.text :caption

      t.integer :user_id

      t.timestamps
    end
  end
end
