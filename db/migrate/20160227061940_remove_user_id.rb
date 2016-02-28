class RemoveUserId < ActiveRecord::Migration
  def change
    remove_column :contributions, :user_id, :string
  end
end
