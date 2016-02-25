class ChangeNameAndBody < ActiveRecord::Migration
  def change
    rename_column :contributions, :name, :item_name
    rename_column :contributions, :body, :comment
  end
end
