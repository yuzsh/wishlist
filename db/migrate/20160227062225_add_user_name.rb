class AddUserName < ActiveRecord::Migration
  def change
    add_column :contributions, :username, :string
  end
end
