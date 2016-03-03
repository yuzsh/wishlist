class CreateGoodWant < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.belongs_to :contribution
      t.belongs_to :user
      t.timestamps :null => false
    end
    
    remove_column :contributions, :good, :integer
  end
end
