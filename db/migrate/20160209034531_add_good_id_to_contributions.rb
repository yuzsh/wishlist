class AddGoodIdToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :good, :integer, default: 0
  end
end
