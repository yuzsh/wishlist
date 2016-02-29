class Association < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :item_name, :null => false
      t.string :comment
      t.string :img
      t.integer :good, :default => 0
      t.integer :want, :default => 0
      t.belongs_to :user
      t.timestamps :null => false
    end
    
    create_table :users do |t|
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :password_digest, :null => false
      t.timestamps :null => false
    end
    
    add_index :users, [:username, :email], :unique => true
  end
end
