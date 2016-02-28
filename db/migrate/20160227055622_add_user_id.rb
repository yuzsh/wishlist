class AddUserId < ActiveRecord::Migration
  def change
    add_column :contributions, :user_id, :integer
    add_column :contributions, :tags, :string
  end
end
