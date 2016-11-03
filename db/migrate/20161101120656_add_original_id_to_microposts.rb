class AddOriginalIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :original_user, :integer
  end
end
