class RemoveSubIdFromPostsAddPostable < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :sub_id

    add_reference :posts, :postable, polymorphic: true, index: true
  end
end
