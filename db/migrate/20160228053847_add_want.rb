class AddWant < ActiveRecord::Migration
  def change
    add_column :contributions, :want, :integer, default: 0
  end
end
