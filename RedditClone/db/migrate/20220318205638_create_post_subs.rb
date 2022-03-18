class CreatePostSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :post_subs do |t|
      t.integer :sub_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end

    add_index :post_subs, :sub_id
    add_index :post_subs, :post_id

    remove_reference :posts, :postable
    add_column :posts, :sub_id, :integer, null: false
    add_index :posts, :sub_id
  end
end
