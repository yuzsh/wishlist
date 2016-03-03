class CreateWant < ActiveRecord::Migration
  def change
    create_table :wants do |t|
      t.belongs_to :contribution
      t.belongs_to :user
      t.timestamps :null => false
    end
    
    remove_column :contributions, :want, :integer
  end
end
